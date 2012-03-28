mult.ev.cens.sim <-
function(foltime, anc.ev, beta0.ev, anc.cens, beta0.cens, z=NA, beta=0, eff=0,
           dist.ev, dist.cens, un.cens, i, max.time, nsit)
  {
    nid          <- vector()
    start        <- vector()  
    stop         <- vector()
    obs          <- vector()
    old          <- vector()
    censor       <- vector()
    it           <- vector()
    tc           <- vector()
    tb           <- vector()
    az1          <- NA
    time         <- vector()
    a.ev         <- NA
    b.ev         <- NA
    a.cens       <- NA
    b.cens       <- NA
    
    obs[1]   <- 0
    k.ev     <- 1
    k.cens   <- 1
    sum      <- 0
    if (!is.na(z[1]) && z[1] == "unif")   az1 <- runif(1, as.numeric(z[2]), as.numeric(z[3]))
    if (!is.na(z[1]) && z[1] == "normal") az1 <- rnorm(1, as.numeric(z[2]), as.numeric(z[3]))
    if (is.na(z[1]))                      az1 <- 0
    for (j in 1:nsit)
    {  
      start[j]   <- 0
      k.ev       <- j
      k.cens     <- j
      nid[j]     <- i
      if (k.ev > length(beta0.ev))     k.ev   <- length(beta0.ev)
      if (k.cens > length(beta0.cens)) k.cens <- length(beta0.cens)
      if (dist.cens[k.cens] == 'llogistic')
      {
        tc[j] <- exp(rlogis(1, beta0.cens[k.cens], anc.cens[k.cens]))
      }else{
        if (dist.cens[k.cens] == 'weibull')
        {
          a.cens   <- anc.cens[k.cens]
          b.cens   <- (1/exp(-anc.cens[k.cens]*(beta0.cens[k.cens])))^(1/anc.cens[k.cens])
          tc[j]    <- rweibull(1, a.cens, b.cens)
        }else{
          if (dist.cens[k.cens] == 'lnorm')
          {
            tc[j]  <- rlnorm(1, beta0.cens[k.cens], anc.cens[k.cens])
          } #if
        } #if
      } #if
      suma <- 0
      if (!is.na(beta[1])) suma <- sum(sapply(beta, "[", k.ev) * eff)
      if (dist.ev[k.ev] == 'llogistic')
      {
        tb[j] <- exp(rlogis(1, beta0.ev[k.ev] + suma + az1, anc.ev[k.ev]))
      }else{
        if (dist.ev[k.ev] == 'weibull')
        {
          a.ev   <- anc.ev[k.ev]
          b.ev   <- (1/exp(-anc.ev[k.ev]*(beta0.ev[k.ev] + suma + az1)))^(1/anc.ev[k.ev])
          tb[j]  <- rweibull(1, a.ev, b.ev)
        }else{
          if (dist.ev[k.ev] == 'lnorm')
          {
            tb[j]  <- rlnorm(1, beta0.ev[k.ev] + suma + az1, anc.ev[k.ev])
          } #if
        } #if
      } #if  
      it[j]      <- 0
      time[j]    <- tc[j]
      old[j]     <- un.cens
      censor[j]  <- TRUE
      if (tb[j] < tc[j])
      {
        it[j]   <- 1
        time[j] <- tb[j]
      }
            
      stop[j]  <- time[j]
      
      if (start[j] < max.time && stop[j] > max.time)
      {
        stop[j]   <- max.time
        time[j]   <- max.time
        it[j]     <- 0
      }
      
      if (start[j] < 0 && stop[j] > 0)
      {
        start[j]  <- 0
        time[j]   <- stop[j]
      }
      
      if (j > 1)  obs[j] <- obs[j-1]
      if (start[j] < foltime && stop[j] > 0 && j > 1)  obs[j] <- obs[j-1] + 1
      if (start[j] < foltime && stop[j] > 0 && j == 1) obs[j] <- 1
      
      j      <- j + 1
      k.ev   <- k.ev + 1
      k.cens <- k.cens + 1
    } #while
    
    sim.ind <- data.frame(nid=nid, ev.num=obs, time=time, 
                          status=it, start=start, stop=stop, old=old, risk.bef=censor, z=az1)
    for (i in 1:length(eff))
    {
      sim.ind <- cbind(sim.ind, x = eff[i])
    }
    
    sim.ind <- subset(sim.ind, start < max.time & start < foltime & stop > 0)
    return(sim.ind)
  }

rec.ev.ncens.sim <-
function(foltime, anc.ev, beta0.ev, anc.cens, beta0.cens, z=NA, beta=0, eff=0, 
                              lambda=NA, dist.ev, dist.cens, max.ep=Inf, un.ncens, i, max.time)
{
   nid          <- vector()
   start        <- vector()  
   start2       <- vector()
   stop         <- vector()
   stop2        <- vector()
   episode      <- vector()
   obs          <- vector()
   old          <- vector()
   censor       <- vector()
   it           <- vector()
   tc           <- vector()
   tb           <- vector()
   az1          <- NA
   long         <- vector()
   time         <- vector()
   time2        <- vector()
   a.ev         <- NA
   b.ev         <- NA
   a.cens       <- NA
   b.cens       <- NA

  j        <- 1
  obs[j]   <- 1
  k.ev     <- 1
  k.cens   <- 1
  sum      <- 0
  sum2     <- 0
  start[j] <- 0
  stop2[j] <- 0
   if (!is.na(z[1]) && z[1] == "gamma")    az1 <- rgamma(1, as.numeric(z[2]), as.numeric(z[3]))
   if (!is.na(z[1]) && z[1] == "exp")      az1 <- rgamma(1, 1, as.numeric(z[2]))
   if (!is.na(z[1]) && z[1] == "weibull")  az1 <- rweibull(1, as.numeric(z[2]), as.numeric(z[3]))
   if (!is.na(z[1]) && z[1] == "unif")     az1 <- runif(1, as.numeric(z[2]), as.numeric(z[3]))
   if (!is.na(z[1]) && z[1] == "invgauss") az1 <- rinvgauss(1, as.numeric(z[2]), as.numeric(z[3]))
   if (is.na(z[1]))                        az1 <- 1
  while ((it[j-1] == 1 || j == 1) && (stop2[j-1] < foltime || j == 1) && j <= max.ep)
  {  
    k.ev       <- j
    k.cens     <- j
    episode[j] <- j
    nid[j]     <- i
    if (k.ev > length(beta0.ev))     k.ev   <- length(beta0.ev)
    if (k.cens > length(beta0.cens)) k.cens <- length(beta0.cens)
    if (dist.cens[k.cens] == 'llogistic')
    {
      tc[j] <- exp(rlogis(1, beta0.cens[k.ev], anc.cens[k.ev]))
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
      tb[j] <- az1*exp(rlogis(1, beta0.ev[k.ev] + suma, anc.ev[k.ev]))
    }else{
      if (dist.ev[k.ev] == 'weibull')
      {
        a.ev   <- anc.ev[k.ev]
        b.ev   <- (1/exp(-anc.ev[k.ev]*(beta0.ev[k.ev] + suma)))^(1/anc.ev[k.ev])
        tb[j]  <- az1*rweibull(1, a.ev, b.ev)
      }else{
        if (dist.ev[k.ev] == 'lnorm')
        {
          tb[j]  <- az1*rlnorm(1, beta0.ev[k.ev] + suma, anc.ev[k.ev])
        } #if
      } #if
    } #if  
    it[j]      <- 0
    time[j]    <- tc[j]
    long[j]  <- NA
    old[j]     <- NA
    censor[j]  <- FALSE
    if (tb[j] < tc[j])
    {
      it[j]   <- 1
      time[j] <- tb[j]
    }
    
    if (it[j] == 1 && !is.na(lambda)) long[j] <-  rtpois(1, lambda[k.ev])
    
    if (j != 1 && !is.na(lambda)) start[j] <- stop[j-1] + long[j-1]
    if (j != 1 && is.na(lambda))  start[j] <- stop[j-1]
    stop[j]  <- start[j] + time[j]
    
    if (start[j] < max.time && stop[j] > max.time)
    {
      stop[j]   <- max.time
      time[j]   <- max.time - start[j]
      it[j]     <- 0
      long[j]   <- NA
    }
    
    if (start[j] < 0 && stop[j] > 0)
    {
      start[j]  <- 0
      time[j]   <- stop[j]
    }
    
    start2[j] <- start[j] + un.ncens
    stop2[j]  <- stop[j] + un.ncens
    time2[j]  <- stop2[j] - start2[j]
    
    if (start2[j] < foltime && stop2[j] > foltime)
    {
      stop2[j]   <- foltime
      time2[j]   <- foltime - start2[j]
      it[j]      <- 0
      long[j]    <- NA
    }
    
    if (start2[j] < 0 && stop2[j] > 0)
    {
      start2[j]  <- 0
      time2[j]   <- stop2[j]
    }
    
    if (j > 1)  obs[j] <- obs[j-1]
    if (start2[j] < foltime && stop2[j] > 0 && j > 1) obs[j] <- obs[j-1] + 1
    
    j      <- j + 1
    k.ev   <- k.ev + 1
    k.cens <- k.cens + 1
  } #while
   
  sim.ind <- data.frame(nid=nid, real.episode=episode, obs.episode=obs, time=time, 
                        status=it, start=start, stop=stop, time2=time2, start2=start2,
                        stop2=stop2, old=old, risk.bef=censor, long=long, 
                        z=az1)
   for (i in 1:length(eff))
   {
     sim.ind <- cbind(sim.ind, x = eff[i])
   }
   sim.ind <- subset(sim.ind, start2 < foltime & stop2 > 0)
  
   return(sim.ind)
}

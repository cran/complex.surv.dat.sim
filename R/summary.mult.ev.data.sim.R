summary.mult.ev.data.sim <-
function(object, ...)
  {
    if(!inherits(object, "mult.ev.data.sim")) stop("Wrong data type")
    sub.risk    <- vector()
    num.events  <- vector()
    foltime     <- vector()
    med.foltime <- vector()
    mean.ep.sub <- vector()
    dens.incid  <- vector()
    ev.num      <- vector()
    pr     <- do.call("rbind", object)
    for (i in 1:attr(object,"nsit"))
    {
       ev.num[i]      <- i
       sub.risk[i]    <- attr(object,"n")
       num.events[i]  <- as.integer(sum(pr$status[pr$ev.num==i]))
       foltime[i]     <- sum(pr$time[pr$ev.num==i])
       med.foltime[i] <- median(pr$time[pr$ev.num==i]) 
       mean.ep.sub[i] <- sum(pr$status[pr$ev.num==i])/length(object)
       dens.incid[i]  <- num.events[i]/foltime[i]
    }
    ans <- data.frame(ev.num, sub.risk, num.events, 
                 foltime, med.foltime,
                 mean.ep.sub, dens.incid)
    class(ans)  <- "summary.mult.ev.data.sim"
    return(ans)
  }

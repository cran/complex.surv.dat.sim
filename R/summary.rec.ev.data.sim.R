summary.rec.ev.data.sim <-
function(object, ...)
{
   if(!inherits(object, "rec.ev.data.sim")) stop("Wrong data type")
   sub.risk    <- vector()
   num.events  <- vector()
   foltime     <- vector()
   med.foltime <- vector()
   mean.ep.sub <- vector()
   dens.incid  <- vector()
   ep.num      <- vector()
   pr     <- do.call("rbind", object)
   for (i in 1:attr(object,"ndist"))
   {
     ep.num[i]      <- i
     if (i != 1)
     {
        sub.risk[i]    <- dim(pr[pr$obs.episode == i-1 & pr$status == 1,])[1]
     }else{
        sub.risk[i] <- attr(object,"n")
     }
     num.events[i]  <- as.integer(sum(pr$status[pr$obs.ep==i]))
     foltime[i]     <- sum(pr$time2[pr$obs.ep==i])
     med.foltime[i] <- median(pr$time2[pr$obs.ep==i]) 
     mean.ep.sub[i] <- sum(pr$status[pr$obs.ep==i])/length(object)
     dens.incid[i]  <- num.events[i]/foltime[i]
   }
   ans <- data.frame(ep.num, sub.risk, num.events, 
                     foltime, med.foltime,
                     mean.ep.sub, dens.incid)
  
   ep.num      <- paste (">", attr(object,"ndist"), sep = " ")
   sub.risk     <- dim(pr[pr$obs.episode == attr(object,"ndist") & pr$status == 1,])[1]
   num.events     <- as.integer(sum(pr$status[pr$obs.ep > attr(object,"ndist")]))
   foltime     <- sum(pr$time2[pr$obs.ep > attr(object,"ndist")])
   med.foltime     <- median(pr$time2[pr$obs.ep > attr(object,"ndist")])
   mean.ep.sub    <- sum(pr$status[pr$obs.ep > attr(object,"ndist")])/length(object)
   dens.incid     <- num.events/foltime
   
   ans2 <- data.frame(ep.num, sub.risk, num.events, 
                     foltime, med.foltime,
                     mean.ep.sub, dens.incid)
   
   ep.num      <- paste ("All episodes", sep = " ")
   sub.risk     <- attr(object,"n")
   num.events     <- as.integer(sum(pr$status))
   foltime     <- sum(pr$time2)
   med.foltime     <- median(pr$time2)
   mean.ep.sub    <- sum(pr$status)/length(object)
   dens.incid     <- num.events/foltime
   
   ans3 <- data.frame(ep.num, sub.risk, num.events, 
                      foltime, med.foltime,
                      mean.ep.sub, dens.incid)
   
   ans4 <- rbind(ans,ans2,ans3)
   class(ans4) <- "summary.rec.ev.data.sim"
   return(ans4)
}

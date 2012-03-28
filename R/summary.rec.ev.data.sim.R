summary.rec.ev.data.sim <-
function(object, ...)
{
   if(!inherits(object, "mult.ev.data.sim") &&
      !inherits(object, "rec.ev.data.sim")) stop("Wrong data type")
   ans <- vector()
   pr         <- do.call("rbind", object)
   ans[1]     <- attr(object,"n")
   ans[2]     <- as.integer(sum(pr$status))
   if (class(object) == "rec.ev.data.sim")
   {
      ans[3]  <- sum(pr$time2)
   }else{
      ans[3]  <- sum(pr$time)
   }
   if (class(object) == "rec.ev.data.sim")
   {
      ans[4]  <- median(pr$time2)
   }else{
      ans[4]  <- median(pr$time) 
   } #if
   ans[5]     <- sum(pr$status)/length(object)
   ans[6]     <- ans[2]/ans[3]
   names(ans) <- c("Number of subjects at risk", "Number of events", "Total time of follow-up",
                   "Time of follow-up (median)", 
                   "Mean episodes per subject", "Density of incidence")
   class(ans) <- "summary.complex.surv.data.sim"
   ans
}

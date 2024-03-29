accum <-
function(data)
{
   # Data check
   if (class(data) != "mult.ev.data.sim" &&
       class(data) != "rec.ev.data.sim") stop("Wrong data type")
   data2 <- data
   for (i in 1:length(data2))
   {
     if (dim(data2[[i]])[1] != 0)
     {
        data2[[i]]$obs.ep.accum[1]  <- sum(data2[[i]]$status) # Observed episodes
        if (class(data) == "rec.ev.data.sim")
        {
           if (data2[[i]][dim(data2[[i]])[1],]$status == 1)
           {
              data2[[i]]$real.ep.accum[1] <- max(data2[[i]]$real.episode)  # Real episodes suffered by the subject
                                                                       # in all his clinical history
              }else{
                 data2[[i]]$real.ep.accum[1] <- max(data2[[i]]$real.episode) - 1 # Real episodes suffered by the subject
                                                                           # in all his clinical history
           }
        }
        if (class(data) == "rec.ev.data.sim")
        {
           data2[[i]]$time.accum[1]  <- sum(na.omit(data2[[i]]$time2))
           data2[[i]]$long.accum[1]  <- sum(na.omit(data2[[i]]$long))
        }else{
           data2[[i]]$time.accum[1]  <- sum(na.omit(data2[[i]]$time))
        }
        data2[[i]] <- data2[[i]][1:1,c(-2,-3,-4,-5,-6,-7,-8,-9,-10,-13)]
     } #if
   } #for  
   class(data2) <- "surv.agg.data"
   return(data2)
}

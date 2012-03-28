print.summary.mult.ev.data.sim <-
function(x, ...)
{
    nn <- names(x)
    for (i in 1:length(x))
    {
      cat("\n")
      cat(nn[i], "\n")
      print(x[[i]], na.print="", quote=TRUE)
      cat("------------------------------------- ")
      cat("\n")
    }
}

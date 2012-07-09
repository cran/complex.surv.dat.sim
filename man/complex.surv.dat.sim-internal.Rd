\encoding{latin1} 
\name{complex.surv.dat.sim-internal}
\alias{complex.surv.dat.sim-internal}
\alias{rtpois}
\alias{mult.ev.ncens.sim}
\alias{rec.ev.cens.sim}
\alias{rec.ev.ncens.sim}
\alias{summary.mult.ev.data.sim}
\alias{print.summary.mult.ev.data.sim}
\alias{summary.rec.ev.data.sim}
\alias{print.summary.rec.ev.data.sim}

\title{Internal complex.surv.dat.sim functions}
\description{Internal complex.surv.dat.simfunctions}
\usage{
rtpois(N, lambda)
mult.ev.ncens.sim(foltime, anc.ev, beta0.ev, anc.cens, beta0.cens, z=NA, beta=0, eff=0,
                  dist.ev, dist.cens, i, nsit)
rec.ev.cens.sim(foltime, anc.ev, beta0.ev, anc.cens, beta0.cens, z=NA, beta=0, eff=0,
                lambda=NA, dist.ev, dist.cens, max.ep=Inf, un.cens, i, max.time)
rec.ev.ncens.sim(foltime, anc.ev, beta0.ev, anc.cens, beta0.cens, z=NA, beta=0, eff=0, 
                 lambda=NA, dist.ev, dist.cens, max.ep=Inf, un.ncens, i, max.time)
\method{summary}{mult.ev.data.sim}(object, ...)
\method{summary}{rec.ev.data.sim}(object, ...)
\method{print.summary}{mult.ev.data.sim}(x, ...)
\method{print.summary}{rec.ev.data.sim}(x, ...)
}

\details{These functions are not to be called by the user}
\seealso{
\code{\link{complex.surv.dat.sim-package}}, \code{\link{accum}}
}
\keyword{internal}

\encoding{latin1} 
\name{accum}
\alias{accum}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Aggregate data from a simulated cohort.
}
\description{
  Aggregate the observed number of events suffered by a subject, the time of follow-up, the duration of all the observed episodes and the real number of events suffered in all subject history.
}
\usage{
  accum(data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
  An object of class \code{mult.ev.data.sim}, if the individual cohort has been simulated in a multiple event situation or an object of class \code{rec.ev.data.sim}, if the individual cohort has been simulated in a recurrent event situation. Note that, although the routine will work, it's probably not much useful in other contexts than recurrent event situation. 
}
}

\details{
The output contains \code{z} and \code{real.ep.accum} because they can be interesting when analyzing several aspects as missing data or individual heterogeneity, although those variables cannot be observed in a real cohort.
}

\value{
  An object of class \code{sim.ev.agg.data}. It is a list with a row for each subject in \code{data}, and the following columns
  \item{nid }{an \code{integer} number that identifies the subject.}
  \item{old }{real value indicating the time that the individual was at risk before the beginning of the follow-up.}
  \item{risk.bef }{\code{Boolean} indicating if the subject was at risk before the beginning of the follow-up time or not.}
  \item{z }{individual heterogeneity, generated according to the specified distribution.}
  \item{x }{ value of each covariate randomly generated for each subject in the cohort.}
  \item{obs.ep.accum }{aggregated number of episodes suffered by an individual since the beginning of subject's follow-up time.}
  \item{real.ep.accum }{aggregated number of episodes suffered by an individual from the beginning of subject's history.}
  \item{time.accum}{global time of follow-up for each individual.}
  \item{long.accum}{global time not at risk within the follow-up time, corresponding to the sum of times between the end of an event and the beginning of the next.}
}

\author{
David Mori�a, Centre Tecnol�gic de Nutrici� i Salut and Albert Navarro, Universitat Aut�noma de Barcelona

}

\seealso{
\code{\link{rec.ev.sim}}, \code{\link{mult.ev.sim}}, \code{\link{complex.surv.dat.sim}}
}
\examples{
### A cohort with 500 subjects, with a maximum follow-up time of 1825 days and
### just a covariate, following a Bernoulli distribution, and a corresponding
### beta of -0.4, -0.5, -0.6 and -0.7 for each episode, in a context of recurrent
### events.

sim.data <- rec.ev.sim(n=500, foltime=1825, dist.ev=c('lnorm','llogistic', 'weibull',
'weibull'),anc.ev=c(1.498, 0.924, 0.923, 1.051),beta0.ev=c(7.195, 6.583, 6.678, 6.430),,
anc.cens=c(1.272, 1.218, 1.341, 1.484),beta0.cens=c(7.315, 6.975, 6.712, 6.399), 
z=c("unif", 0.8,1.2),beta=list(c(-0.4,-0.5,-0.6,-0.7)), x=list(c("bern", 0.5)),
lambda=c(2.18,2.33,2.40,3.46),priskb=0.5,max.old=730)

### Aggregated data

accum.data   <- accum(sim.data)

head(accum.data)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ complex.surv.dat.sim }
\keyword{ aggregated }

\encoding{latin1} 
\name{mult.ev.sim}
\alias{mult.ev.sim}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generate a cohort with multiple events
}
\description{
Simulation of cohorts in a context of multiple event survival analysis including several covariates, individual heterogeneity and periods at risk before and after the initial time of follow-up. 

Multiple event data occurs when each subject can have more than one event of entirely different natures (Kelly, 2000). Examples of this type of event are the occurrence of tumours at different sites in the body or multiple sequalae after a surgery.

We can obtain the observation time of the \eqn{k}-th event in the \eqn{i}-th subject, \eqn{y_ik}, in the same manner that we can simulate \eqn{k} simple independent survival data. Notice that, in multiple-type events, \eqn{T_{ik}} and \eqn{C_{ik}} are mutually independent and, furthermore, the failure (and censorship) in each event is independent of the others (within each subject all \eqn{y_ik} are independents for all \eqn{k}).
}
\usage{
mult.ev.sim(n, foltime, dist.ev, anc.ev, beta0.ev, dist.cens=rep("weibull",length(beta0.cens)), anc.cens, beta0.cens, z=NA, beta=NA, x=NA, priskb=0, max.old=0, nsit)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{
integer value indicating the desired size of the cohort to be simulated.
}
  \item{foltime}{
real number that indicates the maximum time of follow-up of the simulated cohort.
}
  \item{dist.ev}{
vector of arbitrary size indicating the time to event distributions, with possible values \code{weibull} for the Weibull distribution, \code{lnorm} for the log-normal distribution and \code{llogistic} for the log-logistic distribution.
}
  \item{anc.ev}{
vector of arbitrary size of real components containing the ancillary parameters for the time to event distributions.
}
  \item{beta0.ev}{
vector of arbitrary size of real components containing the \eqn{\beta_0} parameters for the time to event distributions.
}
  \item{dist.cens}{
vector of arbitrary size indicating the time to censure distributions, with possible values \code{weibull} for the Weibull distribution, \code{lnorm} for the log-normal distribution and \code{llogistic} for the log-logistic distribution. If no distribution are introduced, the time to censure is assumed to follow as many different Weibull distributions as different parameters are introduced in \code{beta0.cens}.
}
  \item{anc.cens}{
vector of arbitrary size of real components containing the ancillary parameters for the time to censure distributions.
}
  \item{beta0.cens}{
vector of arbitrary size of real components containing the \eqn{\beta_0} parameters for the time to censure distributions.
}
  \item{z}{
vector with three elements that contains information relative to a random effect used in order to introduce individual heterogeneity. The first element indicates the distribution: \code{"unif"} states for the uniform distribution and \code{"normal"} states for the normal distribution. The second and third elements indicates the minimum and maximum in the case of the uniform distribution and the mean and standard deviation in the case of the normal distribution. Its default value is \code{NA}, indicating that no individual heterogeneity is introduced.
}
  \item{beta}{
list of vectors indicating the effect of the corresponding covariate. The number of vectors in \code{beta} must match the number of covariates, and the length of each vector must match the number of events considered. Its default value is NA, indicating that no covariates are included.
}
  \item{x}{
list of vectors indicating the distribution and parameters of any covariate that the user need to introduce in the simulated cohort. The possible distributions are \code{"normal"} for normal distribution, \code{"unif"} for uniform distribution and \code{"bern"} for Bernoulli distribution. Its default value is NA, indicating that no covariates are included. The number of vectors in \code{x} must match the number of vectors in \code{beta}. Each vector in \code{x} must contain the name of the distribution and the parameter(s), the probability of success in Bernoulli case, the mean and the variance for the \code{normal} distribution and the minimum and maximum in the \code{uniform} case.
}
  \item{priskb}{
proportion of subjects at risk before the beginning of follow-up, defaulted to 0.
}
  \item{max.old}{
maximum time at risk before the follow-up time starts.
}
  \item{nsit}{
Number of different events that a subject can suffer. It must match the number of distributions specified in \code{dist.ev}.
}
}
\details{
In order to get the function to work properly, the length of the vectors containing the parameters of the time to event and time to censorship distributions and the number of distributions indicated in the parameter \code{dist.ev} must be the same. Finally, \code{priskb} and \code{max.old} must be positive numbers, with \code{priskb} being between 0 and 1. Notice that if \code{max.old} is big, the routine can expend a long time in order to simulate the cohort with the specified size.
}
\value{
An object of class \code{mult.ev.data.sim}. It is a list where each element is a simulated subject and each row inside an element of the list is an event suffered by the corresponding subject. The columns of each element of the list are detailed below
\item{nid }{an integer number that identifies the subject.}
\item{ev.num }{number of the event corresponding to the follow-up time of the individual.}
\item{time }{time until the corresponding event happens (or time to subject drop-out).}
\item{status }{logical value indicating if the corresponding event has been suffered or not.}
\item{start }{time at which the follow-up time begins for each event.}
\item{stop }{time at which the follow-up time ends for each event.}
\item{old }{real value indicating the time that the individual has been in risk before the beginning of the follow-up.}
\item{risk.bef }{factor that indicates if an individual has been at risk before the beginning of follow-up or not.}
\item{x}{value of each covariate randomly generated for each subject in the cohort.}
}
\references{
Kelly PJ, Lim LL. Survival analysis for recurrent event data: an application to childhood infectious diseases. Stat Med 2000 Jan 15;\bold{19}(1):13-33. 

}

\author{
David Moriña, Centre Tecnològic de Nutrició i Salut and Albert Navarro, Universitat Autònoma de Barcelona
}

\seealso{
\code{\link{complex.surv.dat.sim-package}}, \code{\link{accum}}, \code{\link{rec.ev.sim}}
}
\examples{
### A cohort with 1000 subjects, with a maximum follow-up time of 3600 days and two covariates, following a Bernoulli and uniform distribution respectively, and a corresponding beta of -0.4, -0.5, -0.6 and -0.7 for each event for the first covariate and a corresponding beta of 0, 0, 0 and 1 for each event for the second covariate.

sim.data <- mult.ev.sim(n=1000, foltime=3600, dist.ev=c('llogistic','weibull', 'weibull','weibull'), anc.ev=c(0.69978200185280, 0.79691659193027, 0.82218416457321, 0.85817155198598), 
beta0.ev=c(5.84298525742252, 5.94362650803287, 5.78182528904637, 5.46865223339755),,
anc.cens=c(1.17783687569519, 1.24637732054449, 1.20705354115420, 1.42213732720679), 
beta0.cens=c(7.39773677281100, 7.06105194977482, 6.94661854199131, 6.65642474583347), 
z=c("unif", 0.8,1.2), beta=list(c(-0.4,-0.5,-0.6,-0.7), c(0,0,0,1)), x=list(c("bern", 0.5), c("unif", 0.7, 1.3)), 
priskb=0.3, max.old=300, nsit=4)

summary(sim.data)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ complex.surv.dat.sim }
\keyword{ individual }
\keyword{ multiple }
\keyword{ survival }
\keyword{ simulation }

pkgname <- "complex.surv.dat.sim"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('complex.surv.dat.sim')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("accum")
### * accum

flush(stderr()); flush(stdout())

### Name: accum
### Title: Aggregate data from a simulated cohort.
### Aliases: accum
### Keywords: complex.surv.dat.sim aggregated

### ** Examples

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



cleanEx()
nameEx("mult.ev.sim")
### * mult.ev.sim

flush(stderr()); flush(stdout())

### Name: mult.ev.sim
### Title: Generate a cohort with multiple events
### Aliases: mult.ev.sim
### Keywords: complex.surv.dat.sim individual multiple survival simulation

### ** Examples

### A cohort with 1000 subjects, with a maximum follow-up time of 3600 days and two 
### covariates, following a Bernoulli and uniform distribution respectively, and a 
### corresponding beta of -0.4, -0.5, -0.6 and -0.7 for each event for the first 
### covariate and a corresponding beta of 0, 0, 0 and 1 for each event for the 
### second covariate. Notice that the time to censorship is assumed to follow a 
### Weibull distribution, as no other distribution is stated.

sim.data <- mult.ev.sim(n=1000, foltime=3600, dist.ev=c('llogistic','weibull', 
'weibull','weibull'),anc.ev=c(0.69978200185280, 0.79691659193027, 
0.82218416457321, 0.85817155198598),beta0.ev=c(5.84298525742252, 5.94362650803287,
5.78182528904637, 5.46865223339755),,anc.cens=1.17783687569519,
beta0.cens=7.39773677281100,z=c("unif", 0.8,1.2), beta=list(c(-0.4,-0.5,-0.6,-0.7),
c(0,0,0,1)), x=list(c("bern", 0.5), c("unif", 0.7, 1.3)), nsit=4)

summary(sim.data)



cleanEx()
nameEx("rec.ev.sim")
### * rec.ev.sim

flush(stderr()); flush(stdout())

### Name: rec.ev.sim
### Title: Generate a cohort with recurrent events
### Aliases: rec.ev.sim
### Keywords: complex.surv.dat.sim individual recurrent survival simulation

### ** Examples

### A cohort with 500 subjects, with a maximum follow-up time of 1825 days and 
### just a covariate, following a Bernoulli distribution, and a corresponding 
### beta of -0.4, -0.5, -0.6 and -0.7 for each episode.

sim.data <- rec.ev.sim(n=500, foltime=1825, dist.ev=c('lnorm','llogistic', 
'weibull','weibull'),anc.ev=c(1.498, 0.924, 0.923, 1.051),beta0.ev=c(7.195, 
6.583, 6.678, 6.430),,anc.cens=c(1.272, 1.218, 1.341, 1.484),
beta0.cens=c(7.315, 6.975, 6.712, 6.399), z=c("unif", 0.8,1.2), 
beta=list(c(-0.4,-0.5,-0.6,-0.7)), x=list(c("bern", 0.5)),
lambda=c(2.18,2.33,2.40,3.46), priskb=0.5, max.old=730)

summary(sim.data)



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

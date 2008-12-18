\name{MCPMod-package}
\alias{MCPMod-package}
\docType{package}
\title{
Design and Analysis of Dose-Finding Studies
}
\description{
 This package implements a methodology for dose-response analysis
 that combines aspects of multiple comparison procedures and modeling approaches
 (Bretz, Pinheiro and Branson, (2005)). The package provides tools for the analysis 
 of dose finding trials as well as a variety of tools necessary to plan a trial to 
 be conducted with the MCPMod methodology.}
\details{
\tabular{ll}{
Package: \tab MCPMod\cr
Type: \tab Package\cr
Version: \tab 0.2-1\cr
Date: \tab 2008-12-18\cr
License: \tab GPL-3\cr
}
}
\author{
Bjoern Bornkamp, Jose Pinheiro and Frank Bretz

Maintainer: Bjoern Bornkamp <bornkamp@statistik.tu-dortmund.de>
}
\references{
Bretz, F., Pinheiro, J. C. and Branson, M. (2005), Combining
multiple comparisons and modeling techniques in dose-response
studies, \emph{Biometrics}, \bold{61}, 738--748

Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656

Pinheiro, J. C., Bretz, F. and Branson, M. (2006). Analysis of dose-response studies - modeling 
approaches, \emph{in} N. Ting (ed.). \emph{Dose Finding in Drug Development}, Springer, New York,
pp. 146--171
}
\keyword{ package }
\examples{
# planning a trial for MCPMod
doses <- c(0,10,25,50,100,150)                                             
models <- list(linear = NULL, emax = c(25),                                
               logistic = c(50, 10.88111), exponential = c(85),            
               betaMod = matrix(c(0.33, 2.31, 1.39, 1.39), byrow=TRUE,nrow=2))
plotModels(models, doses, base = 0, maxEff = 0.4, scal = 200) 
sSize <- sampSize(models, doses, base = 0, maxEff = 0.4, sigma = 1,             
           upperN = 80, scal = 200, alpha = 0.05)
sSize
plM <- planMM(models, doses, n = rep(sSize$samp.size,6), scal=200, alpha = 0.05)
plM
plot(plM)

# analysing a trial
data(biom)
models <- list(linear = NULL, linlog = NULL, emax = 0.2,
            exponential = c(0.279,0.15), quadratic = c(-0.854,-1))

dfe <- MCPMod(biom, models, alpha = 0.05, dePar = 0.05, pVal = TRUE,
           selModel = "maxT", doseEst = "MED2", clinRel = 0.4, off = 1)
# detailed information is available via summary
summary(dfe)
# plots data with selected model function
plot(dfe, complData = TRUE, cR = TRUE)
}

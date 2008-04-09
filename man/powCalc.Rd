\name{powCalc}
\alias{powCalc}
\title{ Calculate the power for the multiple contrast test }
\description{
  Given the optimal contrasts, the sample size and a certain `alternative' (i.e. a mean vector and sigma), the
  function calculates the power to detect this alternative. See Pinheiro et al. (2006) for details.
  The function is the building block for the functions \code{powerMM}, \code{sampSize} and \code{LP}.
  Numerical integration routines from the \code{mvtnorm} package are used to calculate the underlying
  multivariate integrals.
}
\usage{
powCalc(cMat, n, alpha = 0.025, delta = NULL, mu = NULL,
        sigma = NULL, cVal = NULL, corMat = NULL,
        twoSide = FALSE, control = mvtnorm.control())
}
\arguments{
  \item{cMat}{ Matrix with the contrasts in the columns }
  \item{n}{ Numeric vector of sample sizes per group. In case just one number
  is specified, it is assumed that all group sample sizes are equal to 
  this number}
  \item{alpha}{ Level of significance (defaults to 0.025)}
  \item{delta}{ Non-centrality vector of the distribution of the test statistic
                under the alternative. }
  \item{mu}{ Mean vector under the alternative. The function then calculates the
             non-centrality vector itself. Ignored if \code{delta} is specified.}
  \item{sigma}{ Expected standard deviation of the response. Only necessary if
                the non-centrality vector is to be calculated by the function (i.e.
                if \code{delta} is NULL). }
  \item{cVal}{ Optional numeric vector giving the critical value, if specified
               the argument \code{alpha} is ignored. }
  \item{corMat}{ An optional matrix giving the correlations of the contrasts
                   specified in \code{cMat}. }
  \item{twoSide}{ Logical indicating whether a two sided or a one sided
                  test should be performed (defaults to one-sided) }
  \item{control}{ A list of options for the \code{pmvt} and \code{qmvt} functions
                 as produced by \code{mvtnorm.control}. }
}
\value{
The function returns the power value.
}
\references{ 
Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{planMM}}, \code{\link{LP}},  \code{\link{sampSize}},  \code{\link{powerMM}}}
\examples{
doses <- c(0,10,25,50,100,150)
models <- list(linear = NULL, emax = c(25),
               logistic = c(50, 10.88111), exponential=c(85),
               betaMod=matrix(c(0.33,2.31,1.39,1.39), byrow=TRUE, nrow=2))

# calculate optimal contrasts and critical value 
plMM <- planMM(models, doses, 50, scal = 200, alpha = 0.05)

# calculate mean vectors
compMod <- fullMod(models, doses, base = 0, maxEff = 0.4, scal = 200)
muMat <- modelMeans(compMod, doses, FALSE, scal = 200)

# calculate power to detect mean vectors
# Power for linear model 
powCalc(plMM$contMat, 50, mu = muMat[,1], sigma = 1, cVal = plMM$critVal)
# Power for emax model  
powCalc(plMM$contMat, 50, mu = muMat[,2], sigma = 1, cVal = plMM$critVal)
# Power for logistic model
powCalc(plMM$contMat, 50, mu = muMat[,3], sigma = 1, cVal = plMM$critVal)
# compare with JBS 16, p. 650
}
\keyword{ design }

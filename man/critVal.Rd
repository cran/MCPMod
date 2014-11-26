\name{critVal}
\alias{critVal}
\title{ Calculate critical value for multiple contrast test}
\description{
  This function calculates the critical value for a multiple
  contrast test via numerical integration (using the methods
  implemented in the \code{mvtnorm} package).
}
\usage{
critVal(cMat, n, alpha = 0.025, control = mvtnorm.control(),
        twoSide = FALSE, corMat = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{cMat}{ A matrix with the contrasts in the columns }
  \item{n}{ A vector giving the sample size per group. If only one number is specified it
  is assumed that the sample sizes are balanced. }
  \item{alpha}{ Level of significance (defaults to 0.025)}
  \item{control}{ A list of options for the \code{pmvt} and \code{qmvt} functions
                 as produced by \code{mvtnorm.control} }
  \item{twoSide}{ Logical indicating if two or one-sided critical value
  should be calculated.}
  \item{corMat}{ Optional: correlation of contrasts matrix can be specified }
}

\value{
  Critical value
}
\references{ 
Bretz, F., Pinheiro, J. and Branson, M. (2005), Combining
Multiple Comparisons and Modeling Techniques in Dose-Response
Studies, \emph{Biometrics}, \bold{61}, 738--748

Hothorn, T., Bretz, F., and Genz, A. (2001), On multivariate t and
Gauss probabilities in R, \emph{R News}, \bold{1}, 27--29
}
\seealso{ \code{\link{planMM}}, \code{\link{mvtnorm.control}} }
\examples{
# Calculation of critical value for Dunnett test
# Set up contrast matrix (3 active doses)
CM <- rbind(-1,diag(3))
# 30 patients per group, one-sided alpha 0.05
critVal(CM, n=30, alpha = 0.05)
# Example from R News 1(2) p. 28, 29
CM <- c(1, 1, 1, 0, 0, -1, 0, 0, 1, 0, 0, -1, 0, 0,
       1, 0, 0, 0, -1, -1, 0, 0, -1, 0, 0)
CM <- t(matrix(CM, ncol = 5))
critVal(CM, n=c(26, 24, 20, 33, 32), alpha = 0.05, 
    twoSide = TRUE)
}
\keyword{ htest }
\keyword{design}

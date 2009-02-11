\name{planMM}
\alias{planMM}
\alias{print.planMM}
\title{ Calculate planning quantities for MCPMod }
\description{
   Calculates the optimal model contrasts, the critical value and the contrast correlation matrix, i.e.
   the quantities necessary to conduct the multiple contrast test for a given candidate set of 
   dose-response models.
}
\usage{
planMM(models, doses, n, off = 0.1 * max(doses), scal = 1.2 * max(doses),
       std = TRUE, alpha = 0.025, twoSide = FALSE,
       control = mvtnorm.control(), cV = TRUE, muMat = NULL)
}
\arguments{
  \item{models}{ A list of candidate models }
   \item{doses}{ A numeric vector giving the doses to be administered. }
  \item{n}{ The vector of sample sizes per group. In case just one number
  is specified, it is assumed that all group sample sizes are equal to 
  this number.}
  \item{off}{ Offset parameter for the linear in log model (default 10 perc of the maximum dose). }
  \item{scal}{ Scale parameter for the beta model (default 20 perc. larger than maximum dose).}
  \item{std}{ Optional logical indicating, whether standardized version
  of the models should be assumed. }
  \item{alpha}{ Level of significance (default: 0.025)}
  \item{twoSide}{ Logical indicating whether a two sided or a one-sided
                  test should be performed. By default FALSE, so one-sided testing. }
  \item{control}{ A list of options for the \code{pmvt} and \code{qmvt} functions
                 as produced by \code{mvtnorm.control} }
  \item{cV}{ Logical indicating whether critical value should be calculated }
  \item{muMat}{ An optional matrix with means in the columns and given dimnames (dose levels
                and names of contrasts). If specified
                the \code{models} argument should not be specified, see examples
                below. }
}
\value{
  An object of class planMM with the following components:
  \item{contMat}{Matrix of optimal contrasts.}
  \item{critVal}{The critical value for the test (if calculated)}
  \item{muMat}{Matrix of (non-normalized) model means}
  \item{corMat}{Matrix of the contrast correlations.}
}
\references{ 
Bornkamp B., Pinheiro J. C., and Bretz, F. (2009). MCPMod: An            
R Package for the Design and Analysis of Dose-Finding        
Studies, \emph{Journal of Statistical Software}, \bold{29}(7), 1--23

Bretz, F., Pinheiro, J., and Branson, M. (2005), Combining
Multiple Comparisons and Modeling Techniques in Dose-Response
Studies, \emph{Biometrics}, \bold{61}, 738--748

Pinheiro, J. C., Bornkamp, B., and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{\code{\link{critVal}}}
\examples{
# Example from JBS paper
doses <- c(0,10,25,50,100,150)
models <- list(linear = NULL, emax = 25,                               
               logistic = c(50, 10.88111), exponential= 85,            
               betaMod=matrix(c(0.33,2.31,1.39,1.39), byrow=TRUE, nrow=2))
plM <- planMM(models, doses, n = rep(50,6), alpha = 0.05, scal=200)
plot(plM)

# example, where means are directly specified
# doses   
dvec <- c(0, 10, 50, 100)
# mean vectors
mu1 <- c(1, 2, 2, 2)
mu2 <- c(1, 1, 2, 2)
mu3 <- c(1, 1, 1, 2)
mMat <- cbind(mu1, mu2, mu3)
dimnames(mMat)[[1]] <- dvec
planMM(muMat = mMat, doses = dvec, n = 30)
}
\keyword{ design }

\name{sampSize}
\alias{sampSize}
\alias{print.sampSize}
\title{ Sample size calculations for MCPMod }
\description{
  Given a candidate set, the baseline effect, the maximum effect and
  the standard deviation, the \code{sampSize} function returns the smallest sample size
  achieving a certain combined power value. See Pinheiro et al. (2006) for details.
}
\usage{
sampSize(models, doses, base, maxEff, sigma, upperN,
         lowerN = floor(upperN/2), power = 0.8, alRatio = NULL,
         sumFct = mean, off = 0.1*max(doses), scal = 1.2 * max(doses),
         alpha = 0.025, twoSide = FALSE, tol = 0.001, verbose = FALSE,
         control = mvtnorm.control(), muMat = NULL,
         typeN = c("arm", "total"), ...)
}
\arguments{
  \item{models}{ A list specifying the candidate models. This
  can also be a fullMod object, then the arguments \code{base}, 
  \code{maxEff}, \code{off} and \code{scal} are ignored }
  \item{doses}{ Dose levels to be administered }
  \item{base}{ Expected baseline effect }
  \item{maxEff}{ Expected maximum change from baseline }
  \item{sigma}{ Expected standard deviation }
  \item{upperN, lowerN}{ Upper and lower bound for the target sample size. \code{lowerN} defaults to
                         \code{floor(upperN/2)}. }
  \item{power}{ Desired combined power value, defaults to 0.8. }
  \item{alRatio}{ Vector describing the relative patient allocations to the dose
                  groups. See Examples below. }
  \item{sumFct}{ A function to combine the power values under the
                 different models into one value. By default the
                 arthmetic mean is used. }
  \item{off}{ Offset parameter for the linear in log model (default 10 perc. of maximum dose). }
  \item{scal}{ Scale parameter for the beta model (default 20 perc. larger than maximum dose).}
  \item{alpha}{ Level of significance (default: 0.025)}
  \item{twoSide}{ Logical indicating whether a two sided or a one-sided
                  test is performed. By default FALSE, so one-sided testing. }
  \item{tol}{ A positive numeric value specifying the tolerance level for the bisection search algorithm. }
  \item{verbose}{ Logical value indicating if a trace of the iteration progress of
                  the bisection search algorithm should be displayed. }
  \item{control}{ A list of options for the \code{pmvt} and \code{qmvt} functions
                 as produced by \code{mvtnorm.control} }
  \item{muMat}{ An optional matrix with means as columns and given dimnames 
                (dose levels and names of contrasts). If specified the
                the \code{models} argument should not be specified, see examples
                below. }
  \item{typeN}{ One of "arm" or "total". Determines, whether the sample size in the
                smallest arm or the total sample size is iterated in bisection
                search algorithm. See examples below. }
  \item{\dots}{ Possible additional arguments for \code{sumFct}  }
}
\details{
Calculates the sample size necessary to achieve a desired combined power value 
for the multiple contrast test. A summary function is used to combine 
the individual power values. The allocation ratios for the dose groups need to be
predefined and fixed (by default balanced allocations are assumed).\cr

The function implements a simple bisection search algorithm to determine the target sample size. In case the upper and
lower bound (\code{upperN}, \code{lowerN}) do not contain the target sample size the algorithm automatically
adjusts these boundaries, but outputs a warning message. 
}
\value{
  An object of class sampSize, with the following components: 
  \item{samp.size}{Vector of target sample size(s)}
  \item{approx.power}{Combined Power achieved under the assumed scenario and sample size.}
}
\references{ 
Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{powCalc}}, \code{\link{powerMM}} }
\examples{
# example from JBS paper p.651
doses <- c(0,10,25,50,100,150)                                         
models <- list(linear = NULL, emax = c(25),                            
               logistic = c(50, 10.88111), exponential=c(85),          
               betaMod=matrix(c(0.33,2.31,1.39,1.39), byrow=TRUE, nrow=2))
sampSize(models, doses, base = 0, maxEff = 0.4, sigma = 1,             
         upperN = 80, scal = 200, alpha = 0.05)
# with different summary function
\dontrun{
sampSize(models, doses, base = 0, maxEff = 0.4, sigma = 1,             
         upperN = 90, scal = 200, sumFct = median, alpha = 0.05)
}
# with unbalanced allocations (twice as many patients in placebo group
# than in active dose groups)
sampSize(models, doses, base = 0, maxEff = 0.4, sigma = 1,            
       alpha = 0.05, upperN = 80, scal = 200, alRatio=c(2,1,1,1,1,1))
# iterates total sample size instead of sample size in smallest arm
# in this case no big difference
\dontrun{
sampSize(models, doses, base = 0, maxEff = 0.4, sigma = 1,
         alpha = 0.05, upperN = 500, scal = 200, typeN = "total",
         alRatio=c(2,1,1,1,1,1))
}

# sample size calculation for general matrix of means
dvec <- c(0, 10, 50, 100)                             
mu1 <- c(1, 2, 2, 2)                                  
mu2 <- c(1, 1, 2, 2)                                  
mu3 <- c(1, 1, 1, 2)                                  
mMat <- cbind(mu1, mu2, mu3)                          
dimnames(mMat)[[1]] <- dvec                           
sampSize(muMat = mMat, doses = dvec, sigma = 1,       
       alpha = 0.05, upperN = 10, alRatio=c(2,2,1,1))
}
\keyword{design}

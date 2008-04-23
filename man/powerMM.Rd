\name{powerMM}
\alias{powerMM}
\title{ Calculate power for different sample sizes }
\description{
  Calculates the power under the assumed candidate set for
  different sample sizes.
}
\usage{
powerMM(models, doses, base, maxEff, sigma, lower, upper, step,
        sumFct = c("min", "mean", "max"), off = 0.1 * max(doses),
        scal = 1.2 * max(doses), alpha = 0.025, twoSide = FALSE,
        control = mvtnorm.control(), muMat = NULL, alRatio = NULL,
        typeN = c("arm", "total"), ...)
}
\arguments{
  \item{models}{ A list specifying the candidate models. This
  can also be a fullMod object, then the arguments \code{base}, 
  \code{maxEff}, \code{off} and \code{scal} are ignored. }
  \item{doses}{ Dose levels to be administered }
  \item{base}{ Expected baseline effect }
  \item{maxEff}{ Expected maximum change from baseline }
  \item{sigma}{ Expected standard deviation }
  \item{lower, upper}{  Maximum and minimum group sample size for
                        which the power is calculated. }
  \item{step}{ Stepsize for the sample size at which the power is calculated.
  It is calculated at \code{seq(lower,upper,by=step)}. }
  \item{sumFct}{ A character vector giving the names of the summary functions used to combine the power values 
                 into one value. By default the minimum, the mean and the maximum are used. }
  \item{off}{ Offset parameter for the linear in log model (default 10 perc. of maximum dose). }
  \item{scal}{ Scale parameter for the beta model (default 20 perc. larger than maximum dose).}
   \item{alpha}{ Level of significance (default: 0.025)}
  \item{twoSide}{ Logical indicating whether a two sided or a one-sided
                  test should be performed. By default FALSE, so one-sided testing. }
  \item{control}{ A list of options for the \code{pmvt} and \code{qmvt} functions
                 as produced by \code{mvtnorm.control}. }
  \item{muMat}{ An optional matrix with means in the columns, dimnames should
                be given (dose levels and names of contrasts), if specified the
                the \code{models} argument should not be specified, see examples
                below. }
  \item{alRatio}{ Vector describing the relative patient allocations to the dose
                  groups. See examples below, e.g. c(1,2,2) corresponds to allocating
                  twice as many patients in dose groups two and three. Per default
                  balanced allocations are assumed. }
  \item{typeN}{ One of "arm" or "total". Determines, whether the sample size in the
                smallest arm or the total sample size is iterated in bisection
                search algorithm. See examples below. }
  \item{\dots}{ Possible additional arguments for sumFct. }
}
\details{
Given the candidate set of models and associated guesstimates the 
function calculates the power to detect every model in the candidate set
for different group sample sizes. 
Additionally summary functions can be specified to calculate the
combined power (by default the minimum, mean and maximum).
The location and scale parameters are determined by forcing 
the model function to go through (0,base) and (dmax,maxEff), see 
Pinheiro et al. (2006) for details. 
There exists a plot method for the output of the powerMM function. See the examples below.
}
\value{
 A \code{powerMM} object, i.e. a matrix containing the power values for different sample sizes and models
}
\references{ 
Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{plot.powerMM}},  \code{\link{powCalc}}}
\examples{
doses <- c(0,10,25,50,100,150)                                         
models <- list(linear = NULL, emax = 25,                               
               logistic = c(50, 10.88111), exponential= 85,            
               betaMod=matrix(c(0.33,2.31,1.39,1.39), byrow=TRUE, nrow=2))
pM <- powerMM(models, doses, base = 0, maxEff = 0.4, sigma = 1,
            alpha = 0.05, lower = 10, upper = 100, step = 20, scal = 200)         
pM
# a graphical display provides plot method
plot(pM)                                
# reproduces plot in JBS 16, p.651      
plot(pM, line.at = 0.8, models = "none")

# the same with fullMod object and default alpha
\dontrun{
fMod <- fullMod(models, doses, base = 0, maxEff = 0.4, scal=200) 
pM <- powerMM(fMod, sigma = 1, lower = 10, upper = 100, 
              step = 20, scal = 200)         
pM
}

# using unbalanced (but fixed) allocations
pM <- powerMM(models, doses, base = 0, maxEff = 0.4, sigma = 1,       
               lower = 10, upper = 100, step = 20, scal = 200,
               alRatio = c(3, 2, 2, 1, 1, 1), typeN = "arm") 
plot(pM, summ = "mean")

# example, where means are directly specified
# doses   
dvec <- c(0, 10, 50, 100)
# mean vectors
mu1 <- c(1, 2, 2, 2)
mu2 <- c(1, 1, 2, 2)
mu3 <- c(1, 1, 1, 2)
mMat <- cbind(mu1, mu2, mu3)
dimnames(mMat)[[1]] <- dvec
pM <- powerMM(muMat = mMat, doses = dvec, sigma = 2, lower = 10,
              upper = 100, step = 20)         
pM
}
\keyword{ design }

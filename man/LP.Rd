\name{LP}
\alias{LP}
\alias{print.LP}

\title{ Sensitivity analysis for misspecification of standardized model parameters }
\description{
Calculates the loss in power associated with 
misspecification of the standardized model parameters for a specific model.
}
\usage{
LP(models, model, type = c("both", "LP1", "LP2"), paramRange,
   doses, base, maxEff, sigma, n, len = c(10, 1), nr = 1,
   alpha = 0.025, twoSide = FALSE, off = 0.1 * max(doses),
   scal = 1.2 * max(doses), control = mvtnorm.control())
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{models}{ A list specifying the candidate models. This
  can also be a fullMod object, then the arguments \code{base}, 
  \code{maxEff}, \code{off} and \code{scal} are ignored }
  \item{model}{ Character string giving the
  model for which the sensitivity should be investigated. }
  \item{type}{ Character string: One of "LP1", "LP2" or "both". }
  \item{paramRange}{ Numeric of length two, giving lower and upper limits for standardized model parameter values
   when the model has just one standardized model parameter. 
   For models with two standardized model parameters a 2x2 matrix with the boundaries
   for each standardized model parameter in the rows. See examples for details. }
  \item{doses}{ Dose levels to be administered }
  \item{base}{ Baseline effect }
  \item{maxEff}{ Maximum change from baseline }
  \item{sigma}{ Standard deviation }
  \item{n}{ Numeric vector of sample sizes per group. In case just one number
  is specified, it is assumed that all group sample sizes are equal to 
  this number.}
  \item{len}{ Number of points in the standardized model parameter range
   on which LP is calculated.  Has to be of length 2 in case of models 
   with 2 standardized model parameters. }
  \item{nr}{ Numeric giving the number of the model (in the order given in the model argument)
  in case there is more than one model from one model class in 
  the candidate set (e.g. two emax models). }
  \item{alpha}{ Level of significance (default: 0.025) }
  \item{twoSide}{ Logical indicating whether a two sided or a one sided
                  test is performed (defaults to one-sided). }
  \item{off}{ Offset parameter for the linear in log model (default 10 perc. of maximum dose). }
  \item{scal}{ Scale parameter for the beta model (default 20 perc. larger than maximum dose).}
  \item{control}{ A list of options for the \code{pmvt} and \code{qmvt} functions
                 as produced by \code{mvtnorm.control} }
}
\details{
For a given set of candidate models the power-sensitivity of 
the multiple contrast test with respect to misspecification 
of the guesstimates is investigated. Two measures to measure loss in 
power ("LP1" or "LP2") can be used. Roughly LP1 can be interpretated 
as the difference between the power that "was
intended" (nominal power), when designing the study and "what one actually gets" (actual power).\cr LP2 can be
interpreted as the difference between "what could be achieved
knowing the true value of the parameter in advance" (potential power) and "what one actually gets". 
For a detailed definition see the reference below.
The power values are calculated on a number of points 
specified by the \code{len} argument. The calculation of
LP2 is computationally more demanding as the optimal contrasts
and the critical value need to be recalculated for each point in the standardized model 
parameter space.
}
\value{
  An object of class LP, i.e. a matrix containing the different alternative 
  standardized model parameters,
  associated potential/actual power values and the loss in power values.
}
\references{ 
Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{plot.LP}}, \code{\link{guesst}} }
\examples{
doses <- c(0,10,25,50,100,150)
models <- list(linear=NULL, emax=c(25),
           logistic=c(50,10.88111), exponential=c(85),
           betaMod=matrix(c(0.33,2.31,1.39,1.39),byrow=TRUE,nrow=2))

# Examples from JBS paper, p.654
LPobj <- LP(models, model = "emax", type = "both", paramRange = c(10,70),
          doses = doses, base = 0, maxEff = 0.4, sigma = 1, n = 60,
          alpha = 0.05, len = 15, scal = 200)
print(LPobj)
plot(LPobj)

# for exponential model with fullMod and LP1:
fMod <- fullMod(models, doses, base = 0, maxEff = 0.4, scal=200)
LPobj <- LP(fMod, "exponential", "LP1", c(50, 120), sigma = 1,
            alpha = 0.05, len = 20, n = 60)
plot(LPobj)

# Examples for models with two standardized model parameters
LP(models, "betaMod", "LP1", 
   paramRange = matrix(c(0.3,1.9,0.4,2.5),nrow=2),
   doses, 0, 0.4, 1, 60, alpha=0.05, len=c(10,4), scal=200)
\dontrun{
#  Time consuming example
LPobj <- LP(models, "logistic", "both",
            paramRange = matrix(c(40,5,60,15),nrow=2),    
            doses, 0, 0.4, 1, 60, alpha=0.05, len=c(10,4), scal=200)
plot(LPobj)
}
}
\keyword{ design }

\name{plotModels}
\alias{plotModels}
\title{ Plot candidate models }
\description{
  Produces a trellis display of the model functions in the candidate set. The location
  and scale parameters of the models are determined by the \code{base} and \code{maxEff}
  arguments.
}
\usage{
plotModels(models, doses, base, maxEff, nPoints = 200, 
           off = 0.1 * max(doses), scal = 1.2 * max(doses), 
           superpose = FALSE, ylab = "Model means", 
           xlab = "Dose", ...)
}

\arguments{
  \item{models}{ A list specifying the candidate models. This
  can also be a fullMod object, then the arguments \code{base}, 
  \code{maxEff}, \code{off} and \code{scal} are ignored. }
  \item{doses}{ Dose levels to be administered }
  \item{base}{ Expected baseline effect }
  \item{maxEff}{ Expected maximum change from baseline }
  \item{nPoints}{ Number of points for plotting }
  \item{off}{ Offset parameter for the linear in log model (default: 10 percent of maximum dose) }
  \item{scal}{ Scale parameter for the beta model (default: 20 percent larger than maximum dose) }
  \item{superpose}{ Logical determining, whether model plots should be superposed }
  \item{ylab, xlab}{ Label for y-axis and x-axis. }
  \item{\dots}{ Additional arguments to the \code{xyplot} call. }
}
\references{ 
Bornkamp B., Pinheiro J. C., Bretz, F. (2009). MCPMod: An            
R Package for the Design and Analysis of Dose-Finding        
Studies, \emph{Journal of Statistical Software}, \bold{29}(7), 1--23

Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{guesst}}, \code{\link{fullMod}} }
\examples{
# JBS example
doses <- c(0,10,25,50,100,150)
models <- list(linear = NULL, emax = c(25),
            logistic = c(50, 10.88111), exponential = c(85),
            betaMod = matrix(c(0.33, 2.31, 1.39, 1.39),
             byrow=TRUE, nrow=2))
plotModels(models, doses, base = 0, maxEff = 0.4, scal = 200) 
# all models in one panel
plotModels(models, doses, base = 0, maxEff = 0.4, scal = 200,
           superpose = TRUE)

# plotModels can also be called using a fullMod object
fM <- fullMod(models, doses, base = 0, maxEff = 0.4, scal = 200)
plotModels(fM)
# or even easier
plot(fM)
}
\keyword{ hplot }

\name{fullMod}
\alias{fullMod}
\title{ Calculate location and scale parameters for candidate set of models }
\description{
    Calculates location and scale parameters for all models in the candidate set
    using the maximum approach from Pinheiro et al. (2006). This is done by repeatedly
    calling the \code{getPars} function.
}
\usage{
fullMod(models, doses, base, maxEff, off = 0.1*max(doses), scal = 1.2 * max(doses))
}
\arguments{
  \item{models}{ A list specifying the candidate models. The names of the list entries should
       be equal to the names of the model functions. The list entries should be equal to the guesstimates  }
  \item{doses}{ Dose levels to be administered }
  \item{base, maxEff}{ Baseline effect and maximum change from baseline to be used for calculating the 
                       location and scale parameters of the model }
  \item{off}{ Offset parameter for the linear in log model }
  \item{scal}{ Scale parameter for the beta model }
}
\value{
  Returns an object of class fullMod, containing all parameter values for the models in a list.
}
\references{ 
Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{getPars}}, \code{\link{sampSize}}, \code{\link{powerMM}}, \code{\link{plotModels}}, \code{\link{LP}}}
\examples{
doses <- c(0, 10, 25, 50, 100, 150)                                        
models <- list(linear = NULL, emax = c(25),                                
               logistic = c(50, 10.88111), exponential = c(85),            
               betaMod = matrix(c(0.33, 2.31, 1.39, 1.39), byrow=TRUE,nrow=2))
fMod <- fullMod(models, doses, base = 0, maxEff = 0.4, scal = 200)                 
plot(fMod) # automatically calls the plotModels function
}
\keyword{ design }

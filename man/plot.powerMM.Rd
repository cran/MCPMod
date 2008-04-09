\name{plot.powerMM}
\alias{plot.powerMM}
\title{ Plot method for powerMM objects}
\description{
  This function plots the result of the \code{powerMM} function call
  in a trellis display.
}
\usage{
\method{plot}{powerMM}(x, superpose = TRUE, line.at = NULL, models = "all",
     summ = NULL, perc = FALSE, xlab = NULL,
     ylab = ifelse(perc, "Power (\%)", "Power"), ...)
}
\arguments{
  \item{x}{ A powerMM object, i.e. a matrix with power values for different sample sizes and models }
  \item{superpose}{ Logical, indicating if lines should be superposed. }
  \item{line.at}{ A value, or a vector of values, between 0 and 1, to be        
           drawn as horizontal line in the plot (default: not drawn).}
  \item{models}{ Character determining which of the models should be included in the plot,            
                 "all" and "none" are accepted, else names (or numbers) of models. }
  \item{summ}{ Summaries to be included in plot; by default the mean, the minimum
               and the maximum value are displayed.}
  \item{perc}{ Logical indicating if power values should be in percentage. }
  \item{xlab}{ Label for x-axis. }
  \item{ylab}{ Label for y-axis. }
  \item{\dots}{ Additional arguments for the \code{xyplot} function. }
}
\references{ Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}

\seealso{ \code{\link{powerMM}} }
\examples{
# Example from JBS paper
doses <- c(0,10,25,50,100,150)                                         
models <- list(linear = NULL, emax = 25,                               
               logistic = c(50, 10.88111), exponential= 85,            
               betaMod=matrix(c(0.33,2.31,1.39,1.39), byrow=TRUE, nrow=2))
pM <- powerMM(models, doses, base = 0, maxEff = 0.4, sigma = 1,       
               lower = 10, upper = 100, step = 20, scal = 200)        
pM
plot(pM)
plot(pM, line.at = 0.8, model = c("emax", "linear"), summ = "mean")
plot(pM, line.at = 0.8, model = "none", summ = c("median", "min"))
}
\keyword{methods}
\keyword{hplot}

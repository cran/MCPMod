\name{plot.LP}
\alias{plot.LP}
\title{ Plot method for LP objects }
\description{
  Graphically displays an LP object.
}
\usage{
\method{plot}{LP}(x, line = TRUE, type = NULL, spldf = 5, ...)
}
\arguments{
  \item{x}{ LP object as obtained from a call to the \code{LP} function }
  \item{line}{ Logical indicating whether the power values should be smoothed. }
  \item{type}{ One of "LP1", "LP2" or "both", availability depending on whether
               the corresponding values have been calculated in the call to
               the \code{LP} function. }
  \item{spldf}{ Numeric determining the degrees of freedom for the smoothing spline
                which is plotted if \code{line==TRUE}. Note that \code{spldf} should
                be larger than 1 and smaller than \code{len} (default: 5).}
  \item{\dots}{ Additional arguments. }
}
\details{
The function produces a trellis display of the loss in power for different values
of the standardized model parameter. A smoothing spline (with \code{spldf} degrees of freedom) is fit to these 
points to give a smooth impression of the loss in power curve. 
For models with two prior parameters
a trellis display is shown with the number of panels equal to \code{len[2]}.
The number of points on which the power is evaluated is equal to \code{len[1]}
in each panel, where \code{len} is an argument of the \code{LP} function.
}

\seealso{ \code{\link{LP}} }
\examples{
doses <- c(0,10,25,50,100,150)                                           
models <- list(linear=NULL, emax=c(25),
           logistic=c(50,10.88111), exponential=c(85),
           betaMod=matrix(c(0.33,2.31,1.39,1.39),byrow=TRUE,nrow=2))

# Examples from JBS paper, p.654
LPobj <- LP(models, model = "emax", type = "both", paramRange = c(10,70),
           doses = doses, base = 0, maxEff = 0.4, sigma = 1, n = 60,     
           alpha = 0.05, len = 15, scal = 200)
plot(LPobj)
plot(LPobj, line = FALSE, type = "LP1")
plot(LPobj, type = "LP1", spldf = 9)
}
\keyword{methods}
\keyword{hplot}

\name{plot.planMM}
\alias{plot.planMM}
\title{Plotting a planMM object}
\description{
  This function displays the contrasts or model means obtained from
  a planMM object.
}
\usage{
\method{plot}{planMM}(x, superpose = TRUE, xlab = "Dose",
     ylab = NULL, resp = c("contrasts", "means"), ...)
}
\arguments{
  \item{x}{ A planMM object. }
  \item{superpose}{ Logical, indicating if lines should be superposed. }
  \item{xlab}{ Label for x-axis }
  \item{ylab}{ Label for y-axis }
  \item{resp}{ One of "contrasts" or "means". Determines, whether contrasts or
               normalized means are plotted. }
  \item{\dots}{ Additional arguments to the \code{xyplot} function call. }
}

\seealso{ \code{\link{planMM}} }
\examples{
\dontrun{
doses <- c(0, 10, 25, 50, 100, 150)
models <- list(linear = NULL, emax = c(25),
               logistic = c(50, 10.88111), exponential = c(85),
               betaMod = matrix(c(0.33, 2.31, 1.39, 1.39),
                byrow=TRUE,nrow=2))
pM <- planMM(models, doses, 50, scal = 200)
plot(pM)
plot(pM, superpose=FALSE, xlab="Different axis name")
plot(pM, resp = "means")
# example with muMat
dvec <- c(0, 10, 50, 100)
mu1 <- c(1, 2, 2, 2)
mu2 <- c(1, 1, 2, 2)
mu3 <- c(1, 1, 1, 2)
mMat <- cbind(mu1, mu2, mu3)
dimnames(mMat)[[1]] <- dvec
pM <- planMM(muMat = mMat, doses = dvec, n = 30)
plot(pM)
plot(pM, superpose=FALSE, xlab="Different axis name")
}
}
\keyword{methods}
\keyword{hplot}

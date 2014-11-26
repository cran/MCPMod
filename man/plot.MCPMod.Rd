\name{plot.MCPMod}
\alias{plot.MCPMod}
\title{Plot MCPMod model fits}
\description{
  The function plots the model(s) used for dose estimation.
}
\usage{
\method{plot}{MCPMod}(x, complData = FALSE, CI = FALSE, clinRel = FALSE, doseEst = FALSE,
     gamma = NULL, models = "all", nrDoseGam = 1,
     colors = c("black", "blue", "black", "gray", "blue"),
     uGrad = NULL, ...)
}
\arguments{
  \item{x}{ A MCPMod object. }
  \item{complData}{ Logical indicating whether complete data set or group means should be plotted. }
  \item{CI}{ Logical indicating whether a confidence interval should be plotted along the
             model fit(s). }
  \item{clinRel}{ Logical indicating, whether clinical relevance threshold should be included in plot. }
  \item{doseEst}{ Logical determining whether dose estimate should be included in plot. }
  \item{gamma}{ Numeric giving the value for the 1-2*gamma pointwise CI around
           the predicted mean. if equal to NULL the value
           determined in the MCPMod call is used. In case
           a vector of gamma values was used \code{nrDoseGam} determines which
           is used. }
  \item{models}{  Character vector determining, which of the used
            models should be plotted (only available if model averaging was used) }
  \item{nrDoseGam}{ In case a vector is specified for \code{dePar} in 
              the MCPMod function (and gamma in the plot.MCPMod
              function is NULL), nrDoseGam determines which of
             these values should be used for the conf. interval
              and the dose estimate (if doseEst = T). }
  \item{colors}{ Vector of length 5 with the names of the colors for:
            predictions, CI, data, clinical relevance threshold,
            dose estimator }
  \item{uGrad}{ If a user defined model has been used for dose estimation, the gradient
                function needs to be handed over via uGrad. }
  \item{\dots}{ Additional arguments to xyplot. }
}

\seealso{ \code{\link{MCPMod}} }
\keyword{methods}
\keyword{hplot}

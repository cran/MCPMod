\name{modelMeans}
\alias{modelMeans}
\title{ Calculate mean vectors for a given candidate set }
\description{
  Calculates the mean or standardized mean vectors for a candidate
  set of models. This function is mainly for internal use.
}
\usage{
modelMeans(models, doses, std = TRUE, off = 0.1 * max(doses),
           scal = 1.2 * max(doses))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{models}{ A list of candidate models, or the output
                 of the \code{fullMod} function (depending on the 
                 value of \code{std}). }
  \item{doses}{ A numeric vector giving the doses to be administered. }
  \item{std}{ Logical indicating whether standardized or non-standardized
              version of model function should be used. }
  \item{off}{ Offset parameter for linear in log model. }
  \item{scal}{ Scale parameter for beta model. }
}

\value{
  Matrix with standardized or non-standardized model means.
}
\examples{
doses <- c(0, 10, 25, 50, 100, 150)                                        
models <- list(linear = NULL, emax = c(25),                                
               logistic = c(50, 10.88111), exponential = c(85),            
               betaMod = matrix(c(0.33, 2.31, 1.39, 1.39), byrow=TRUE,nrow=2))
modelMeans(models, doses, std = TRUE)

# now non-standardized means
Models <- fullMod(models, doses, base = 0, maxEff = 0.4, scal = 200)                 
modelMeans(Models, doses, std = FALSE)
}
\keyword{misc}

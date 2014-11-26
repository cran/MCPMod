\name{genDFdata}
\alias{genDFdata}
\title{ Simulate dose-response data }
\description{
  The function simulates normally distributed dose-response data, 
  according to a prespecified dose-response model (or mean vector)
  and a given standard deviation.
}
\usage{
genDFdata(model, argsMod, doses, n, sigma, mu = NULL)
}
\arguments{
  \item{model}{ Character string giving the name of a model function. The first
                argument of the model function should be the dose variable. }
  \item{argsMod}{ A vector with the arguments for the model function. }
  \item{doses}{ Dose levels to be used. }
  \item{n}{ Group sample sizes. }
  \item{sigma}{ Standard deviation. }
  \item{mu}{ If \code{model} is not specified mu is used to determine
             the mean vector of the observations. }
}
\value{
  A data frame with two columns called \code{dose} and \code{resp}, corresponding to the dose and 
  simulated response values.
}
\examples{
# use emax model
genDFdata("emax", c(e0 = 0.2, eMax = 1, ed50 = 0.05), c(0,0.05,0.2,0.6,1), 20, 1)
# use fixed mean vector
genDFdata(mu = 1:5, doses = 0:4, n = c(20, 20, 10, 5, 1), sigma = 0.2)
}
\keyword{ datagen }

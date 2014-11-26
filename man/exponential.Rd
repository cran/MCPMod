\name{exponential}
\alias{exponential}
\title{ Exponential (power) model }
\description{
  The model function for the exponential model is defined as
 \deqn{
  f(d,\theta)=E_0+E_1(exp(d/\delta)-1)}{f(d,theta)=E0+E1 (exp(d/delta)-1).}
}
\usage{
exponential(dose, e0, e1, delta)
}
\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{e1}{ E1 parameter }
  \item{delta}{ Delta parameter, controlling the convexity of the model. }
}
\details{
  This model is intended to capture a possible sub-linear or a
  convex dose-response relationship. 
}
\value{
Response value
}
\references{
Pinheiro, J. C., Bretz, F. and Branson, M. (2006). Analysis of dose-response studies - modeling 
approaches, \emph{in} N. Ting (ed.). \emph{Dose Finding in Drug Development}, Springer, New York,
pp. 146--171
}
\seealso{ \code{\link{logistic}}, \code{\link{sigEmax}}, 
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{quadratic}},
          \code{\link{emax}},  \code{\link{betaMod}}
          }
\keyword{ models }

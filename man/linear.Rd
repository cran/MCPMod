\name{linear}
\alias{linear}
\title{ Linear Model }
\description{
  The model function for the linear model is defined as
 \deqn{
  f(d,\theta)=E_0+\delta d}{f(d,theta)=E0+delta d.}
}
\usage{
linear(dose, e0, delta)
}
\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{delta}{ Slope parameter }
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
          \code{\link{linlog}}, \code{\link{exponential}}, \code{\link{quadratic}},
          \code{\link{emax}},  \code{\link{betaMod}}
          }
\keyword{ models }

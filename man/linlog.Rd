\name{linlog}
\alias{linlog}
\title{ Linear in log dose Model }
\description{
  The model function for the linear in log model is defined as
 \deqn{
  f(d,\theta)=E_0+\delta \log(d + off)}{f(d,theta)=E0+delta log(d + off),} where \eqn{off}{off} is an offset parameter not estimated in the code.
}
\usage{
linlog(dose, e0, delta, off = 1)
}
\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{delta}{ Slope parameter }
  \item{off}{ Offset value to avoid problems with dose=0 (treated as a
fixed value in the code) }
}
\details{
  The linear in log-dose model is intended to capture concave
  shapes. The parameter \code{off} is not estimated in the code
  but set to a pre-specified value.
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
          \code{\link{linear}}, \code{\link{exponential}}, \code{\link{quadratic}},
          \code{\link{emax}},  \code{\link{betaMod}}
          }

\keyword{ models }

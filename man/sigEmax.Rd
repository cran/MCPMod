\name{sigEmax}
\alias{sigEmax}
\title{ Sigmoid Emax Model }
\description{
  The model function for the sigmoid Emax model is defined as
 \deqn{
  f(d,\theta)=E_0+E_{max}\frac{d^h}{ED^h_{50}+d^h}}{f(d,theta)=E0+Emax d^h/(ED50^h + d^h).}
}
\usage{
sigEmax(dose, e0, eMax, ed50, h)
}

\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{eMax}{ Asymptotic maximum change from placebo effect }
  \item{ed50}{ Dose giving half of the asymptotic maximum effect }
  \item{h}{ Hill parameter, determining the steepness of the model at the ED50 }
}

\details{
  The sigmoid Emax model is an extension of the (hyperbolic) Emax model by introducing an
  additional parameter h, that determines the steepness of the curve
  at the ed50 value. The sigmoid Emax model describes monotonic, sigmoid dose-response
  relationships.
}
\value{
Response value
}
\references{ 
MacDougall, J. (2006). Analysis of dose-response studies - Emax model,\emph{in} N. Ting (ed.),
\emph{Dose Finding in Drug Development}, Springer, New York, pp. 127--145
}

\seealso{ \code{\link{emax}}, \code{\link{logistic}}, \code{\link{betaMod}}, 
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{quadratic}},
          \code{\link{exponential}}
          }
\keyword{models}

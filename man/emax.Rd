\name{emax}
\alias{emax}
\title{ Emax model }
\description{
  The model function for the Emax model is defined as
 \deqn{
  f(d,\theta)=E_0+E_{max}\frac{d}{ED_{50}+d}}{f(d,theta)=E0+Emax d/(ED50 + d).}
}
\usage{
emax(dose, e0, eMax, ed50)
}
\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{eMax}{ Asymptotic maximum change from placebo effect }
  \item{ed50}{ Dose giving half of the asymptotic maximum effect }
}
\details{
  The emax model is used to represent monotone, concave dose-response shapes.
  To distinguish it from the more general sigmoid emax model it is sometimes 
  also called hyperbolic emax model.
}
\value{
 Response value
}
\references{ 
MacDougall, J. (2006). Analysis of dose-response studies - Emax model,\emph{in} N. Ting (ed.),
\emph{Dose Finding in Drug Development}, Springer, New York, pp. 127--145

Pinheiro, J. C., Bretz, F. and Branson, M. (2006). Analysis of dose-response studies - modeling 
approaches, \emph{in} N. Ting (ed.). \emph{Dose Finding in Drug Development}, Springer, New York,
pp. 146--171
}
\seealso{ \code{\link{sigEmax}}, \code{\link{logistic}}, \code{\link{betaMod}}, 
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{quadratic}},
          \code{\link{exponential}}
}
\keyword{ models }

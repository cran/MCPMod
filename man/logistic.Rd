\name{logistic}
\alias{logistic}
\title{ Logistic Model }
\description{
  The model function for the logistic model is defined as
   \deqn{
    f(d, \theta) = E_0 + E_{\max}/\left\{1 + \exp\left[ \left(ED_{50} - d
  \right)/\delta \right] \right\}}{f(d,theta)=E0+Emax/(1 + exp((ED50-d)/delta)).}

}
\usage{
logistic(dose, e0, eMax, ed50, delta)
}
\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Left-asymptote parameter, corresponding to a basal effect level 
             (not the placebo effect, though). }
  \item{eMax}{ Asymptotic maximum change in effect from the basal level. }
  \item{ed50}{ Dose giving half of the asymptotic maximum effect. }
  \item{delta}{ Parameter controlling determining the steepness of the curve. }
}

\details{
  The logistic model is intended to capture general monotone, 
  sigmoid dose-response relationships.
}
\value{
Response value
}
\references{
Pinheiro, J. C., Bretz, F. and Branson, M. (2006). Analysis of dose-response studies - modeling 
approaches, \emph{in} N. Ting (ed.). \emph{Dose Finding in Drug Development}, Springer, New York,
pp. 146--171
}
\seealso{ \code{\link{betaMod}}, \code{\link{logistic}}, \code{\link{sigEmax}}, 
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{quadratic}},
          \code{\link{exponential}}
          }
\keyword{ models }

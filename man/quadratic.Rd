\name{quadratic}
\alias{quadratic}
\title{ Quadratic model }
\description{
  The model function for the quadratic model is defined as
 \deqn{
  f(d,\theta)=E_0+\beta_1d+\beta_2d^2}{f(d,theta)=E0+beta1 d+beta2 d^2.}
}
\usage{
quadratic(dose, e0, b1, b2)
}

\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{b1}{ beta1 parameter }
  \item{b2}{ beta2 parameter (controls, whether model is convex or concave) }
}
\details{
  This model is intended to capture a possible non-monotonic
  dose-response relationship.
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
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{exponential}},
          \code{\link{emax}},  \code{\link{betaMod}}
          }
\keyword{ models }

\name{betaMod}
\alias{betaMod}
\title{ Beta model }
\description{
  The beta model is defined as
  \deqn{
  f(d,\theta)=E_0+E_{max}B(\delta_1,\delta_2)(d/scal)^{\delta_1}(1-d/scal)^{\delta_2}
  }{f(d,theta)=E0+Emax B(delta1,delta2)(d/scal)^delta1(1-d/scal)^delta2}
  where \deqn{B(\delta_1,\delta_2)=(\delta_1+\delta_2)^{\delta_1+\delta_2}/(\delta_1^{\delta_1} \delta_2^{\delta_2})}{B(delta1,delta2)=(delta1+delta2)^(delta1+delta2)/(delta1^delta1 delta2^delta2).}
}
\usage{
betaMod(dose, e0, eMax, delta1, delta2, scal)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dose}{ Dose variable }
  \item{e0}{ Placebo effect }
  \item{eMax}{ Maximum effect }
  \item{delta1}{ delta1 parameter }
  \item{delta2}{ delta2 parameter }
  \item{scal}{ Scale parameter (not estimated in the code) }
}
\details{
The beta model is intended to capture non-monotone
dose-response relationships and is more flexible than the quadratic model.
The kernel of the beta model
function consists of the kernel of the density function of a beta
distribution on the interval [0,scal]. The parameter
scal is not estimated but needs to be set to a value 
larger than the maximum dose via the argument \code{scal}.
}
\value{
 Response value
}
\seealso{ \code{\link{logistic}}, \code{\link{sigEmax}}, 
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{quadratic}},
          \code{\link{emax}},  \code{\link{exponential}}
          }

\keyword{ models }

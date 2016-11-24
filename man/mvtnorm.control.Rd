\name{mvtnorm.control}
\alias{mvtnorm.control}
\title{ Control options for pmvt and qmvt functions }
\description{
  Returns a list with control parameters (an object of class GenzBretz) 
  for the \code{pmvt} and \code{qmvt} functions from the \code{mvtnorm} 
  package, see the corresponding documentation for more information.
}
\usage{
mvtnorm.control(maxpts = 30000, abseps = 0.001,
                interval = NULL, releps = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{maxpts}{ Maximum number of function values as integer. }
  \item{abseps}{ Absolute error tolerance as double.  }
  \item{interval}{ A vector containing the end-points of the interval to be searched 
                   for the critical value. }
  \item{releps}{ Relative error tolerance as double.  }
  \item{\dots}{ Additional arguments to \code{pmvt} or \code{qmvt}.  }
}

\seealso{ \code{\link[mvtnorm]{pmvt}}, \code{\link[mvtnorm]{qmvt}} }

\keyword{ misc }

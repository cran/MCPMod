\name{IBS}
\alias{IBS}
\docType{data}
\title{ Irritable Bowel Syndrome Dose Response data }
\description{
A subset of the data used by (Biesheuvel and Hothorn, 2002). 
Except for the dose and the response variable all variables from the original data set
are removed. 
The data are part of a dose ranging trial on a compound for the treatment of the
irritable bowel syndrome with four active treatment arms,
corresponding to doses 1,2,3,4 and placebo. Note that the original dose levels
have been blinded in this data set for confidentiality. The primary endpoint
was a baseline adjusted abdominal pain score with larger values
corresponding to a better treatment effect. In total 369 patients
completed the study, with nearly balanced allocation across the
doses.
}
\usage{data(IBS)}
\format{
  A data frame with 369 observations on the following 2 variables.
  \describe{
    \item{\code{dose}}{a numeric vector}
    \item{\code{resp}}{a numeric vector}
  }
}

\source{
Biesheuvel, E. and Hothorn, L. A. (2002). Many-to-one comparisons in stratified designs,
\emph{Biometrical Journal}, \bold{44}, 101--116
}
\keyword{datasets}

\name{getPars}
\alias{getPars}
\title{ Calculate location and scale parameters }
\description{
  Given the baseline, the maximum effect and the standardized model parameters
  this function calculates the location and scale parameters in the
  model function using the maximum approach, see Pinheiro et al. (2006) for the basic idea.
}
\usage{
getPars(model, doses, initEstim, base, maxEff,
        off = 0.1 * max(doses), scal = 1.2 * max(doses))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{ A character string with the model name. Built-in models    
        have their full parameterization derived internally. For   
      user-defined models, it is assumed that a      
      function named as "Par" appended to end of model name exists (e.g.,    
      for model = "cubic", it is assumed that there is function  
      "cubicPar" that calculates the necessary parameters; this    
       function is assumed to have arguments "doses", "initEstim",    
      "base", and "maxEff", in that order (see below for an example).  }
  \item{doses}{  Doses to be used in design   }
  \item{initEstim}{ Vector of guesstimates }
  \item{base}{ Expected baseline effect }
  \item{maxEff}{ Expected maximum change from baseline }
  \item{off}{ Offset parameter for the linear in log model (default 1). }
  \item{scal}{ Scale parameter for the beta model (default: 20 perc. larger than maximum dose).}
}
\value{
Vector containing all model parameters.
}
\references{ 
Pinheiro, J. C., Bornkamp, B. and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656
}
\seealso{ \code{\link{fullMod}}}
\examples{
doses <- c(0, 10, 25, 50, 100, 150)                                        
getPars("emax", doses, 25, 0, 0.4)                                         
getPars("logistic", doses, c(50, 10.88111), 0, 0.4) # compare JBS 16, p.650
getPars("betaMod", doses, initEstim = c(0.33, 2.31), base = 0,             
        maxEff = 0.4)                                                      
#example for user model                                                    
userMod <- function(dose, e0, eMax, ed50, h){                             
  e0 + eMax * ( dose^h / (ed50^h + dose^h) )                               
}                                                                          
# function to return location and scale parameters                         
userModPar <- function(dose, initEstim, base, maxEff){                    
  # function to get linear parameters                                      
  # ed50 parameter assumed to be first in initEstim                        
  ed50 <- initEstim[1]                                                     
  h <- initEstim[2]                                                        
  dmax <- max(dose)                                                        
  emax <- maxEff*(ed50^h+dmax^h)/dmax^h                                    
  c(base, emax, initEstim)                                                 
}                                                                          
getPars("userMod", doses, initEstim = c(50,2), base = 0, maxEff = 1) 
}     
\keyword{ models }
\keyword{ design }

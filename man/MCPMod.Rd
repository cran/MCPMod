\name{MCPMod}
\alias{MCPMod}
\alias{print.MCPMod}
\alias{print.summary.MCPMod}
\alias{summary.MCPMod}
\title{Perform MCPMod analysis of a data set}
\description{
Tests for a dose-response effect with a model-based multiple contrast test and
estimates a target dose with regression techniques. For details see
Bretz et al. (2005) or the enclosed vignette, available via the command \code{vignette("MCPMod")}.
}
\usage{
MCPMod(data, models = NULL, contMat = NULL, critV = NULL, resp = "resp",
       dose = "dose", off = NULL, scal = NULL, alpha = 0.025, 
       twoSide = FALSE, selModel = c("maxT", "AIC", "BIC", "aveAIC", 
       "aveBIC"), doseEst = c("MED2", "MED1", "MED3", "ED"), std = TRUE,
       start = NULL, uModPars = NULL, addArgs = NULL, dePar = NULL,
       clinRel = NULL, lenDose = 101, pW = NULL,
       control = list(maxiter = 100, tol = 1e-06, minFactor = 1/1024),
       signTtest = 1, pVal = FALSE, testOnly = FALSE,
       mvtcontrol = mvtnorm.control(), na.action = na.fail, uGrad = NULL)
}

\arguments{
  \item{data}{Data frame containing the dose and the response data. The code assumes
               the columns to be named "dose" and "resp". Other names can be handed over via
               the \code{dose} and \code{resp} argument see below. }
  \item{models}{ A list specifying the candidate models. The names of the list entries should
  be equal to the names of the model functions. The list entries should be equal to the guesstimates. See the Examples (ii)
  for details on this topic. If the \code{contMat} argument is specified, this argument is ignored, see Examples (iv). }
  \item{contMat}{ Optional matrix containing the optimal contrasts in the columns. The names of the columns 
  should be equal to the underlying model function names. If specified the code does not calculate the optimal contrasts.}
  \item{critV}{ Optional numeric specifying the critical value to be used in the multiple
  contrast test. }
  \item{resp}{ Character string giving the name of the response column for the data frame
               specified in \code{data} (default: "resp"). }
  \item{dose}{ Character string giving the name of the dose column for the data frame
               specified in \code{data} (default: "dose"). }
  \item{off}{ Fixed offset parameter needed when the linear in log model is used. 
              See also documentation of the linear in log model: \code{\link{linlog}}. 
              When \code{off = NULL} by default (maximum dose)*0.1 is
              used for \code{off}. }
  \item{scal}{ Fixed scale parameter needed when the beta model is used. 
              See also documentation of the beta model: \code{\link{betaMod}}. 
              When \code{scal = NULL} by default (maximum dose)*1.2 is
              used for \code{scal}.}
  \item{alpha}{ Level of significance for the multiple contrast test (defaults to 0.025)  }
  \item{twoSide}{ Optional logical value deterimining whether two-sided or one-sided testing should be
                  performed. Defaults to FALSE, so one-sided testing. }
  \item{selModel}{ Optional character vector specifying the model selection criterion for dose estimation. Possible values are \cr
                   "maxT": Selects the model corresponding to the largest t-statistic (this is the default).\cr
                   "AIC": Selects model with smallest AIC\cr
                   "BIC": Selects model with smallest BIC\cr
                   "aveAIC": Uses a weighted average of the models corresponding to the significant contrasts.
                           The model weights are chosen by the formula: wi = exp(-0.5AICi)/sum(exp(-0.5AICi)).
                           See Buckland et al. (1997) for details.\cr
                   "aveBIC": Same as "aveAIC", but the BIC is used to calculate the model weights.\cr
                   }
  \item{doseEst}{ Determines which dose to estimate and which dose estimator to use, possible
                  values are "MED2", "MED1", "MED3" and "ED". See Bretz et al. (2005) for the definition
                  of MED1-MED3. If ED is specified, the dose that gives a pre-specified percentage of
                  the maximum effect is returned.}
  \item{std}{ Optional logical value determining, whether standardized versions should be assumed
              for calculation of the optimal contrasts. If FALSE all model parameters need to be specified
              in the models argument (also location and scale parameters). }
  \item{start}{ List containing starting values for the nls fitting algorithm. The names of the list elements 
                need to be equal to the names of the model functions. The names of the starting vector should equal the
                corresponding names for the model parameters. For built-in models starting values need to be provided
                only for the non-linear parameters. In case of a user model (not built in)
                starting values for the all parameters need to be supplied. (see Examples (iii) for details). }
  \item{uModPars}{ Optional character vector with names/expressions of user-defined model parameters (names(start) used by
                  default). }
  \item{addArgs}{ Optional character vector with names of additional arguments (variables) to user-defined model. }
  \item{dePar}{ Numeric, defining parameter used for dose estimators. For the MED-type estimators \code{dePar} determines
                 the confidence level gamma used in the estimator. The used confidence level is given by
                 \code{1-2*dePar}. The default for \code{dePar} for MED-type estimators is 0.1. For ED-type estimators \code{dePar}
                 determines which effective dose is estimated. Specifying 0.95 for example results in an estimate of the ED95.
                 If the ED estimator is used the default for \code{dePar} is 0.5. }
  \item{clinRel}{ Numeric specifying the clinical relevance threshold. }
  \item{lenDose}{ Numeric vector specifying the number of points in the dose-range
                  to search for the dose estimate, defaults to 101. }
  \item{pW}{ Optional vector specifying prior weights for the different models. Should be a named vector with names
              matching the names of the models list.}
  \item{control}{ List of parameters to be used in the calls to the \code{nls} function. See also
                   \code{nls.control} function. }
  \item{signTtest}{ Optional numeric vector multiplied with the test statistics. }
  \item{pVal}{ Optional logical determining whether p-values should be calculated, defaults to FALSE. If the critical value is supplied,
     p-values will not be calculated. }
  \item{testOnly}{ Logical value determining, whether only the multiple comparisons test should be performed. See Examples (v) below.}
  \item{mvtcontrol}{ A list specifying additional control parameters for the \code{qmvt} and \code{pmvt} calls in the code,
                     see also \code{mvtnorm.control} for details. }
  \item{na.action}{ A function which indicates what should happen when the data contain NAs.  }
  \item{uGrad}{ Function to return the gradient of a user defined model, see Examples (iii) below. }
}
\details{
This function performs the multiple comparisons and modelling (MCPMod) procedure presented in
Bretz et al. (2005). The method consists of two steps:\cr
(i) MCP step:
    The function calculates the optimal contrasts (if not supplied) and 
    the contrast test statistics. In the calculation of the critical 
    value and p-values multiplicity is taken into account.\cr
(ii) Modelling step:
    If there is at least one significant contrast, one model or a combination
    of models is chosen (depending on the \code{selModel} argument) for dose estimation.
    In case of non-convergence of certain non-linear models the 
    remaining significant models are used. Finally the target dose is estimated.\cr

    Built in models are the linear, linear in log, emax, sigmoid emax, logistic, 
    exponential, quadratic and beta model (for their definitions see their help files or 
    Bretz et al. (2005), Pinheiro et al. (2006)).
    Users may hand over their own model functions for details have a look at the Example (iii).
}
\value{
  An object of class MCPMod, with the following entries:
  \item{signf}{Logical indicating, whether multiple contrast test is significant}
  \item{model1}{Model with largest contrast test statistic}
  \item{model2}{Model(s) used for estimation of target doses}
  \item{input}{A list with entries equal to the input parameters for the function: \code{models}, \code{resp}, \code{dose},
              \code{off}, \code{scal}, \code{alpha}, \code{twoSide}, first entry of \code{selModel}, \code{doseEst}, 
              \code{std}, \code{dePar}, \code{uModArgs}, \code{addArgs}, \code{start}, \code{uGrad}, \code{clinRel}, 
              \code{lenDose}, \code{signTtest}, \code{pVal}, \code{testOnly}}
  \item{data}{The data set.}
  \item{contMat}{The contrast matrix.}
  \item{corMat}{The correlation matrix.}
  \item{cVal}{The critical value for the multiple contrast test.}
  \item{tStat}{The contrast test-statistics. If 'pVal=TRUE' the p-values are also attached.}
  \item{fm}{List containing the dose-response model(s) used for dose-estimation. WARNING: The
            model fitting is for computational efficiency done based on the group
            means and for positive non-linear parameters (e.g. the ED50 parameter in the Emax model) the 
            estimate in \code{fm} is on log scale. The summary.MCPMod method shows the parameters on their original scale.
            Hence some care is hence needed when extracting the fitted model objects from \code{fm}
            (in particular when interest is in standard deviations of predictions, parameter estimates...).
            }
  \item{tdose}{Estimated target dose, in case of model averaging the dose estimates under
               the individual models are attached.}
Note: If \code{testOnly=TRUE}, or no model is significant, the object does not contain \code{fm} and \code{tdose} entries
}
\references{
Bornkamp B., Pinheiro J. C., and Bretz, F. (2009). MCPMod: An            
R Package for the Design and Analysis of Dose-Finding        
Studies, \emph{Journal of Statistical Software}, \bold{29}(7), 1--23
 
Bretz, F., Pinheiro, J. C., and Branson, M. (2005), Combining
multiple comparisons and modeling techniques in dose-response
studies, \emph{Biometrics}, \bold{61}, 738--748

Pinheiro, J. C., Bornkamp, B., and Bretz, F. (2006). Design and analysis of dose finding studies
combining multiple comparisons and modeling procedures, \emph{Journal of Biopharmaceutical
Statistics}, \bold{16}, 639--656

Pinheiro, J. C., Bretz, F., and Branson, M. (2006). Analysis of dose-response studies - modeling 
approaches, \emph{in} N. Ting (ed.). \emph{Dose Finding in Drug Development}, Springer, New York,
pp. 146--171

Bretz, F., Pinheiro, J. C., and Branson, M. (2004), On a hybrid
method in dose-finding studies, \emph{Methods of Information in Medicine},
\bold{43}, 457--460

Buckland, S. T., Burnham, K. P. and Augustin, N. H. (1997). Model selection an integral part
of inference, \emph{Biometrics}, \bold{53}, 603--618
}
\seealso{ \code{\link{logistic}}, \code{\link{sigEmax}}, 
          \code{\link{linlog}}, \code{\link{linear}}, \code{\link{quadratic}},
          \code{\link{emax}},  \code{\link{betaMod}}, \code{\link{exponential}},
          \code{\link{plot.MCPMod}}, \code{\link{mvtnorm.control} }
          }
\examples{
\dontrun{
# (i)
# example from Biometrics paper p. 743
data(biom)
models <- list(linear = NULL, linlog = NULL, emax = 0.2,
            exponential = c(0.279,0.15), quadratic = c(-0.854,-1))
dfe <- MCPMod(biom, models, alpha = 0.05, dePar = 0.05, pVal = TRUE,
           selModel = "maxT", doseEst = "MED2", clinRel = 0.4, off = 1)
# detailed information is available via summary
summary(dfe)
# plots data with selected model function
plot(dfe)

# example with IBS data
data(IBS)
models <- list(emax = 0.2, quadratic = -0.2, linlog = NULL)
dfe2 <- MCPMod(IBS, models, alpha = 0.05, pVal = TRUE,
             selModel = "aveAIC", clinRel = 0.25, off = 1)
dfe2
# show more digits in the output
print(dfe2, digits = 8)
summary(dfe2, digits = 8)
plot(dfe2, complData = TRUE, cR = TRUE)
plot(dfe2, CI = TRUE)

# simulate dose-response data
dfData <- genDFdata(model = "emax", argsMod = c(e0 = 0.2, eMax = 1, 
          ed50 = 0.05), doses = c(0,0.05,0.2,0.6,1), n=20, sigma=0.5)
models <- list(emax = 0.1, logistic = c(0.2, 0.08), 
             betaMod = c(1, 1))
dfe3 <- MCPMod(dfData, models, clinRel = 0.4, critV = 1.891, 
           scal = 1.5)
}
# (ii) Example for constructing a model list

# Contrasts to be included:
# Model             guesstimate(s) for stand. model parameter(s) (name)
# linear            -
# linear in log     -
# Emax              0.2 (ED50)
# Emax              0.3 (ED50)
# exponential       0.7 (delta)
# quadratic        -0.85 (delta)
# logistic          0.4  0.09 (ED50, delta)
# logistic          0.3  0.1 (ED50, delta)
# betaMod           0.3  1.3 (delta1, delta2) 
# sigmoid Emax      0.5  2 (ED50, h)
#
# For each model class exactly one list entry needs to be used.
# The names for the list entries need to be written exactly 
# as the model functions ("linear", "linlog", "quadratic", "emax", 
# "exponential", "logistic", "betaMod", "sigEmax").
# For models with no parameter in the standardized model just NULL is 
# specified as list entry.
# For models with one parameter a vector needs to be used with length
# equal to the number of contrasts to be used for this model class.
# For the models with two parameters in the standardized model a vector
# is used to hand over the contrast, if it is desired to use just one
# contrast. Otherwise a matrix with the guesstimates in the rows needs to
# be used. For the above example the models list has to look like this

list(linear = NULL, linlog = NULL, emax = c(0.2, 0.3),
     exponential = 0.7, quadratic = -0.85, logistic =
     matrix(c(0.4, 0.3, 0.09, 0.1), nrow = 2),
     betaMod = c(0.3, 1.3), sigEmax = c(0.5, 2))

# Additional parameters (who will not be estimated) are the "off"
# parameter for the linlog model and the "scal" parameter for the
# beta model, which are not handed over in the model list.


# (iii) example for incorporation of a usermodel
# simulate dose response data
dats <- genDFdata("sigEmax", c(e0 = 0, eMax = 1, ed50 = 2, h = 2),
              n = 50, sigma = 1, doses = 0:10)
# define usermodel
userMod <- function(dose, a, b, d){
  a + b*dose/(dose + d)
}
# define gradient
userModGrad <- 
    function(dose, a, b, d) cbind(1, dose/(dose+d), -b*dose/(dose+d)^2)    
# name starting values for nls
start <- list(userMod=c(a=0, b=1, d=2))       
models <- list(userMod=c(0, 1, 1), linear = NULL)
MM1 <- MCPMod(dats, models, clinRel = 0.4, selModel="AIC", start = start,
         uGrad = userModGrad)

# (iv) Contrast matrix and critical value handed over and not calculated
# simulate dose response data
dat <- genDFdata(mu = (0:4)/4, n = 20, 
                       sigma = 1, doses = (0:4)/4)
# construct optimal contrasts and critical value with planMM
doses <- (0:4)/4
mods <- list(linear = NULL, quadratic = -0.7)
pM <- planMM(mods, doses, 20)
MCPMod(dat, models = NULL, clinRel = 0.3, contMat = pM$contMat,
     critV = pM$critVal)
\dontrun{
# (v) Using MCPMod for mutiple contrast tests only
mu1 <- c(1, 2, 2, 2, 2)                      
mu2 <- c(1, 1, 2, 2, 2)                      
mu3 <- c(1, 1, 1, 2, 2)                      
mMat <- cbind(mu1, mu2, mu3)              
dimnames(mMat)[[1]] <- doses               
pM <- planMM(muMat = mMat, doses = doses, n = 20, cV = FALSE)
# calculate p-values
fit <-MCPMod(dat, models = NULL, clinRel = 0.3, contMat = pM$contMat,
        pVal = TRUE, testOnly = TRUE)
summary(fit)
}
}
\keyword{ models }
\keyword{ htest }

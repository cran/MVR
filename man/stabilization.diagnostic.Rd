\name{stabilization.diagnostic}
\alias{stabilization.diagnostic}
\title{Function for Plotting Summary Variance Stabilization Diagnostic Plots}
\description{
    Plot comparative variance-mean plots to check the variance stabilization across variables before and after Mean-Variance Regularization.
}
\usage{
    stabilization.diagnostic(obj, 
                             title = "", 
                             span = 0.5, 
                             degree = 2, 
                             family = "gaussian", 
                             device = NULL, 
                             file = "Summary Stabilization Diagnostic Plots")
}

\arguments{
  \item{obj}{Object of class "\code{mvr}" returned by \code{\link[MVR]{mvr}}.}
  \item{title}{Title of the plot. Defaults to the empty string.}
  \item{span}{Span parameter of the \code{loess()} function (R package \pkg{stats}), which controls the degree of smoothing. 
              Defaults to 0.75.}
  \item{degree}{Degree parameter of the \code{loess()} function (R package \pkg{stats}), which controls the degree of the polynomials to be used. 
                Defaults to 2. (Normally 1 or 2. Degree 0 is also allowed, but see the "Note" in loess {stats} package.)}
  \item{family}{Family distribution in {"gaussian", "symmetric"} of the \code{loess()} function (R package \pkg{stats}), used for local fitting .
                If "gaussian" fitting is by least-squares, and if "symmetric" a re-descending M estimator is used with Tukey's biweight function.}
  \item{device}{Graphic display device in \{NULL, "PS", "PDF"\}. Defaults to NULL (screen).
                Currently implemented graphic display devices are "PS" (Postscript) or "PDF" (Portable Document Format).}
  \item{file}{File name for output graphic. Defaults to "Summary Stabilization Diagnostic Plots".}
}
\details{
    In the plots of standard deviations vs. means, standard deviations and means are calculated in a feature-wise manner from the expression matrix.
    The scatterplot allows to visually verify whether there is a dependence of the standard deviation (or variance) on the mean. 
    The black dotted line depicts the LOESS scatterplot smoother estimator. If there is no variance-mean dependence, 
    then this line should be approximately horizontal.
    
    Option \code{file} is used only if device is specified (i.e. non \code{NULL}).
}
\value{
    None. Displays the plots on the chosen \code{device}.
}
\references{
    \itemize{
        \item Dazard, J-E. and J. S. Rao (2010). "\emph{Regularized Variance Estimation and Variance Stabilization of High-Dimensional Data.}"
        JSM Proceedings. High-Dimensional Data Analysis and Variable Selection Section., Vancouver, BC. Canada, American Statistical Association.
        \item Dazard, J-E. and J. S. Rao (2011). "\emph{Joint Adaptive Mean-Variance Regularization and Variance Stabilization of High Dimensional Data.}" 
        Comput. Statist. Data Anal. (submitted).
    }
}
\author{
    \itemize{
        \item Jean-Eudes Dazard, Ph.D. \email{jxd101@case.edu}
        \item Hua Xu, Ph.D. \email{hxx58@case.edu}
        \item Alberto Santana, MBA. \email{ahs4@case.edu}
        \item J. Sunil Rao, Ph.D. \email{JRao@med.miami.edu}
    }
    Maintainer: Jean-Eudes Dazard, Ph.D. \email{jxd101@case.edu}
    
    Acknowledgments: This project was partially funded by the 
    National Institutes of Health (P30-CA043703 to J-E.DAZARD, R01-GM085205 to J.S.RAO), 
    and the National Science Foundation (DMS-0806076 to J.S.RAO).
}
\note{
    End-user function.
}

\seealso{
    \code{justvsn} (R package \pkg{vsn}) Variance stabilization and calibration for microarray data.
    \code{loess} (R package \pkg{stats}) Fit a polynomial surface determined by one or more numerical predictors, using local fitting.
}

\examples{
\dontrun{
#===================================================
# Loading the library and its dependencies
#===================================================
library("MVR")
require("statmod", quietly = TRUE)
require("snow", quietly = TRUE)
require("RColorBrewer", quietly = TRUE)

#===================================================
# Loading of the Synthetic and Real datasets 
# (see description of datasets)
#===================================================
data("Synthetic", "Real", package="MVR")

#===================================================
# Mean-Variance Regularization (Real dataset)
# Multi-Group Assumption
# Assuming unequal variance between groups
# Without Rocks cluster usage
#===================================================
nc.min <- 1
nc.max <- 30
probs <- seq(0, 1, 0.01)
n <- 6
GF <- factor(gl(n = 2, k = n/2, len = n), 
             ordered = FALSE, 
             labels = c("M", "S"))
mvr.obj <- mvr(data = Real, 
               block = GF, 
               log = FALSE, 
               nc.min = nc.min, 
               nc.max = nc.max, 
               probs = probs,
               B = 100, 
               parallel = FALSE, 
               conf = NULL,
               verbose = TRUE)

#===================================================
# Summary Stabilization Diagnostic Plots (Real dataset)
# Multi-Group Assumption
# Assuming unequal variance between groups
#===================================================
stabilization.diagnostic(obj = mvr.obj, 
                         title = "Summary Stabilization Diagnostic Plots 
                         (Real - Multi-Group Assumption)",
                         span = 0.75, 
                         degree = 2, 
                         family = "gaussian",
                         device = "PS")

#===================================================
# Mean-Variance Regularization (Real dataset)
# Single-Group Assumption
# Assuming equal variance between groups
# Without Rocks cluster usage
#===================================================
nc.min <- 1
nc.max <- 30
probs <- seq(0, 1, 0.01)
n <- 6
mvr.obj <- mvr(data = Real, 
               block = rep(1,n), 
               log = FALSE, 
               nc.min = nc.min, 
               nc.max = nc.max, 
               probs = probs, 
               B = 100, 
               parallel = FALSE, 
               conf = NULL, 
               verbose = TRUE)

#===================================================
# Summary Stabilization Diagnostic Plots (Real dataset)
# Single-Group Assumption
# Assuming equal variance between groups
#===================================================
stabilization.diagnostic(obj = mvr.obj, 
                         title = "Summary Stabilization Diagnostic Plots 
                         (Real - Single-Group Assumption)", 
                         span = 0.75, 
                         degree = 2, 
                         family = "gaussian",
                         device = NULL)

}
}
\keyword{Mean-Variance Estimators}
\keyword{Regularization}
\keyword{Variance Stabilization}
\keyword{Normalization}



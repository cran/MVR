\name{normalization.diagnostic}
\alias{normalization.diagnostic}
\title{Function for Plotting Summary Normalization Diagnostic Plots}
\description{    
    Plot comparative Box-Whisker and Heatmap plots of variables across samples check the effectiveness 
    of normalization before and after Mean-Variance Regularization.
}
\usage{
    normalization.diagnostic(obj, 
                             title = "",
                             pal,
                             device = NULL, 
                             file = "Summary Normalization Diagnostic Plots")
}

\arguments{
  \item{obj}{Object of class "\code{mvr}" returned by \code{\link[MVR]{mvr}}.}
  \item{title}{Title of the plot. Defaults to the empty string.}
  \item{pal}{Color palette.}
  \item{device}{Graphic display device in \{NULL, "PS", "PDF"\}. Defaults to NULL (screen).
                Currently implemented graphic display devices are "PS" (Postscript) or "PDF" (Portable Document Format).}
  \item{file}{File name for output graphic. Defaults to "Summary Normalization Diagnostic Plots".}
}
\details{
    Option \code{file} is used only if device is specified (i.e. non \code{NULL}).
    The argument \code{pal} can be any color palette, e.g. as provided by R package \pkg{RColorBrewer}.
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
# Summary Normalization Diagnostic Plots (Real dataset)
# Multi-Group Assumption
# Assuming unequal variance between groups
#===================================================
normalization.diagnostic(obj = mvr.obj, 
                         title = "Summary Normalization Diagnostic Plots 
                         (Real - Multi-Group Assumption)",
                         pal = brewer.pal(n=11, name="RdYlGn"),
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
# Summary Normalization Stabilization Diagnostic Plots (Real dataset)
# Single-Group Assumption
# Assuming equal variance between groups
#===================================================
normalization.diagnostic(obj = mvr.obj, 
                         title = "Summary Normalization Diagnostic Plots 
                         (Real - Single-Group Assumption)", 
                         pal = brewer.pal(n=11, name="RdYlGn"),
                         device = NULL)

}
}
\keyword{Mean-Variance Estimators}
\keyword{Regularization}
\keyword{Variance Stabilization}
\keyword{Normalization}



\name{cluster.diagnostic}
\alias{cluster.diagnostic}
\title{Function for Plotting Summary Cluster Diagnostic Plots}
\description{
    Plot similarity statistic profiles and the optimal joint clustering configuration for the means and the variances by group.
    
    Plot quantile profiles of means and standard deviations by group and for each clustering configuration, to check that the distributions 
    of first and second moments of the MVR-transformed data approch their respective null distributions under the optimal configuration found, 
    assuming independence and normality of all the variables.
}
\usage{
    cluster.diagnostic(obj, 
                       title = "", 
                       span = 0.75, 
                       degree = 2, 
                       family = "gaussian", 
                       device = NULL, 
                       file = "Summary Cluster Diagnostic Plots")
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
  \item{file}{File name for output graphic. Defaults to "Summary Cluster Diagnostic Plots".}
}
\details{
    In the plot of similarity statistic profiles, the red dashed line depicts the LOESS scatterplot smoother estimator.
    The subroutine internally generates null distributions of the data with target mean-0 and standard deviation-1 (e.g. \eqn{N(0, 1)})
    for computing the similarity statistic that applies to each cluster configuration. The optimal one found is indicated by the red arrow,
    where the similarity statistic reaches its minimum plus/minus one standard deviation (applying the conventional one-standard deviation rule).
    A smaller cluster number configuration indicates underfitting, while overfitting starts to occur at larger numbers.

    The comparative quantile mean plot and quantile standard deviation plot check how close the empirical quantiles of means 
    and standard deviations of the MVR-transformed data are to that of their respective theoretical null distributions (solid green lines) 
    for each cluster configuration (the single cluster configuration, corresponding to no transformation, is the most vertical curve, while 
    the largest cluster number configuration reaches horizontality). Under the assumption of standard normality and independence for the data under the null, 
    the theoretical null distributions of the means and the standard deviations are respectively \eqn{N(0, 1)}, 
    and \eqn{\sqrt{\frac{\chi_{n - G}^{2}}{n - G}}}, where \eqn{G} denotes the number of sample groups 
    (see \cite{Dazard, J-E. and J. S. Rao (2011)} for more details). The optimal cluster configuration found is indicated by the most horizontal red curve. 
    One should see a convergence towards the target null, after which overfitting starts to occur. 

    Both cluster diagnostic plots help determine whether appropriate values of the \code{nc.min} and \code{nc.max} parameters have been set in 
    the \code{\link[MVR]{mvr}} as well as in \code{\link[MVR]{mvrt.test}} functions. The minimum of the similarity statistic profile 
    has to be reached within the range \code{nc.min}:\code{nc.max}, otherwise run the procedure again with a wider range until this is the case.  
           
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
# Summary Cluster Diagnostic Plots (Real dataset)
# Multi-Group Assumption
# Assuming unequal variance between groups
#===================================================
cluster.diagnostic(obj = mvr.obj, 
                   title = "Summary Cluster Diagnostic Plots 
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
# Summary Cluster Diagnostic Plots (Real dataset)
# Single-Group Assumption
# Assuming equal variance between groups
#===================================================
cluster.diagnostic(obj = mvr.obj, 
                   title = "Summary Cluster Diagnostic Plots 
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



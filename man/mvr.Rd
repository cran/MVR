\name{mvr}
\alias{mvr}
\title{Function for Mean-Variance Regularization and Variance Stabilization}
\description{
    End-user function for Mean-Variance Regularization (MVR) and Variance Stabilization by similarity statistic
    under sample group homoscedasticity or heteroscedasticity assumption.
    
    Return an object of class "\code{mvr}". Offers the option of parallel computation for improved efficiency.
    See vignette \file{Cluster_Setup.pdf}.             
}
\usage{
    mvr(data, 
        block = rep(1,nrow(data)),
        tolog = FALSE, 
        nc.min = 1, 
        nc.max = 30, 
        probs = seq(0, 1, 0.01),
        B = 100, 
        parallel = FALSE,
        conf = NULL,
        verbose = TRUE)
}
\arguments{
  \item{data}{\code{numeric} \code{matrix} of untransformed (raw) data, 
              where samples are by rows and variables (to be clustered) are by columns, 
              or an object that can be coerced to such a \code{matrix} (such as a \code{numeric} \code{vector} 
              or a \code{data.frame} with all \code{numeric} columns). 
              Missing values (\code{NA}), NotANumber values (\code{NaN}) or Infinite values (\code{Inf}) are not allowed.}
  \item{block}{\code{character} or \code{numeric} \code{vector} or \code{factor} grouping/blocking variable of length the sample size. 
               Defaults to single group situation (see details).}
  \item{tolog}{\code{logical} scalar. Is the data to be log2-transformed first? Optional, defaults to \code{FALSE}.
             Note that negative or null values will be changed to 1 before taking log2-transformation.}
  \item{nc.min}{Positive \code{integer} scalar of the minimum number of clusters, defaults to 1}
  \item{nc.max}{Positive \code{integer} scalar of the maximum number of clusters, defaults to 30}
  \item{probs}{\code{numeric} \code{vector} of probabilities for quantile diagnostic plots. Defaults to \code{seq}(0, 1, 0.01).}
  \item{B}{Positive \code{integer} scalar of the number of Monte Carlo replicates of the inner loop 
           of the sim statistic function (see details).}
  \item{parallel}{\code{logical} scalar. Is parallel computing to be performed? Optional, defaults to \code{FALSE}.}           
  \item{conf}{\code{list} of parameters for cluster configuration.
              Inputs for R package \pkg{snow} function \code{makeCluster} (R package \pkg{snow}) for cluster setup.
              Optional, defaults to \code{NULL}. See details for usage.}
  \item{verbose}{\code{logical} scalar. Is the output to be verbose? Optional, defaults to \code{TRUE}.}
}
\details{
    Argument \code{block} is a \code{vector} or a \code{factor} grouping/blocking variable. It must be of length sample size 
    with as many different \code{character} or \code{numeric} values as the number of levels or sample groups.
    It defaults to single group situation, i.e. under the assumption of equal variance between sample groups.
    All group sample sizes must be greater than 1, otherwise the program will stop.
    
    Argument \code{B} is reset to \code{conf$cpus}*\code{ceiling}(\code{B}/\code{conf$cpus}) in case the Rocks cluster 
    is used (i.e. \code{conf} is non \code{NULL}), where \code{conf$cpus} denotes the total number of CPUs to be used (see below).
    
    Argument \code{nc.max} currently defaults to 30. This depends (among others) on the number \eqn{p} of variables. 
    We found in our hands that this is enough for most datasets tested where \eqn{p < 10000}, and/or especially after log-transformation. 
    For higher dimensional datasets and/or without log-transformation, larger values of \code{nc.max} may be required.
    See the cluster diagnostic function \code{\link[MVR]{cluster.diagnostic}} for more details.
    
    To run a parallel session (and parallel RNG) of the MVR procedures (\code{parallel}=\code{TRUE}), argument \code{conf} is to be specified (i.e. non \code{NULL}).
    It must list the specifications of the folowing parameters for cluster configuration: ("cpus", "type", "homo", "script", "outfile") matching the 
    arguments and options described in function \code{makeCluster} of the R package \pkg{snow}:
    \itemize{
        \item "cpus": \code{spec} : \code{integer} scalar specifying the total number of CPU cores, counting the masternode.
        \item "type": \code{type} : \code{character} vector specifying the cluster type ("SOCK", "PVM", "MPI").
        \item "homo": \code{homogeneous} : \code{logical} scalar to be set to \code{FALSE} for inhomogeneous clusters. 
              (optional, defaults to \code{TRUE}).
        \item "script": \code{useRscript} : \code{logical} scalar to be set to \code{FALSE} if non-R script is used. 
              (optional, defaults to \code{TRUE}).
        \item "outfile": \code{outfile} : \code{character} vector of the output log file name for the slavenodes. 
              (optional, defaults to \code{""}).
    }
    Note that the actual creation of the cluster, its initialization, and closing are all done internally. 
    In addition, when random number generation is needed, the creation of separate Stream of Parallel RNG (SPRNG) per node
    is done internally by distributing the stream states to the nodes (For more details see vignette \file{Cluster_Setup.pdf} 
    and see function \code{makeCluster} (R package \pkg{snow}) and/or \url{http://www.stat.uiowa.edu/~luke/R/cluster/cluster.html}.
}
\value{
    \item{Xraw}{\code{numeric} \code{matrix} of original data.}
    \item{Xmvr}{\code{numeric} \code{matrix} of MVR-transformed data.}
    \item{centering}{\code{numeric} \code{vector} of centering values
                     for standardization (cluster mean of pooled sample mean).}
    \item{scaling}{\code{numeric} \code{vector} of scaling values
                   for standardization (cluster mean of pooled sample std dev).}
    \item{MVR}{\code{list} (of size the number of groups) containing
               \code{\link[MVR]{MeanVarReg}} values.}
    \item{block}{Value of argument \code{block}.}
    \item{tolog}{Value of argument \code{tolog}.}
    \item{nc.min}{Value of argument \code{nc.min}.}
    \item{nc.max}{Value of argument \code{nc.max}.}
    \item{probs}{Value of argument \code{probs}.}
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
    \itemize{
        \item \code{makeCluster} (R package \pkg{snow}) Simple Network of Workstations.
        \item \code{justvsn} (R package \pkg{vsn}) Variance stabilization and calibration for microarray data \cite{Huber, 2002}
    }
}
\examples{
#===================================================
# Loading the library and its dependencies
#===================================================
library("MVR")
require("statmod", quietly = TRUE)
require("snow", quietly = TRUE)
require("RColorBrewer", quietly = TRUE)

#===================================================
# MVR package news
#===================================================
MVR.news()

#================================================
# MVR package citation
#================================================
citation("MVR")

#===================================================
# Loading of the Synthetic and Real datasets 
# (see description of datasets)
#===================================================
data("Synthetic", "Real", package="MVR")

#===================================================
# Mean-Variance Regularization (Synthetic dataset)
# Single-Group Assumption
# Assuming equal variance between groups
# Without Rocks cluster usage
#===================================================
nc.min <- 1
nc.max <- 15
probs <- seq(0, 1, 0.01)
n <- 10
mvr.obj <- mvr(data = Synthetic, 
               block = rep(1,n), 
               tolog = FALSE, 
               nc.min = nc.min, 
               nc.max = nc.max, 
               probs = probs, 
               B = 100, 
               parallel = FALSE, 
               conf = NULL, 
               verbose = TRUE)
 
\dontrun{
#===================================================
if (.Platform$OS.type == "unix") {
    if (!is.loaded("rpvm")) {
            library("rpvm")
    }
}
masterhost <- Sys.getenv("HOSTNAME")
slavehosts <- unlist(strsplit(Sys.getenv("HOSTS"), split="\\n"))
.PVM.start.pvmd(hosts = masterhost) 
.PVM.addhosts(hosts = slavehosts)
#===================================================

#===================================================
cpus <- as.numeric(Sys.getenv("NUMCPU"))
nodes <- length(slavehosts) + 1
conf <- list("cpus" = nodes * cpus, 
             "type" = getClusterOption("type"), 
             "homo" = getClusterOption("homogeneous"), 
             "script" = getClusterOption("useRscript"),
             "outfile" = "")
#===================================================

#===================================================
# Mean-Variance Regularization (Real dataset)
# Multi-Group Assumption
# Assuming unequal variance between groups
# With Rocks cluster usage
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
               tolog = FALSE, 
               nc.min = nc.min, 
               nc.max = nc.max, 
               probs = probs,
               B = 100, 
               parallel = TRUE, 
               conf = conf,
               verbose = TRUE)

#===================================================
# Mean-Variance Regularization (Real dataset)
# Single-Group Assumption
# Assuming equal variance between groups
# With Rocks cluster usage
#===================================================
nc.min <- 1
nc.max <- 30
probs <- seq(0, 1, 0.01)
n <- 6
mvr.obj <- mvr(data = Real, 
               block = rep(1,n), 
               tolog = FALSE, 
               nc.min = nc.min, 
               nc.max = nc.max, 
               probs = probs, 
               B = 100, 
               parallel = TRUE, 
               conf = conf, 
               verbose = TRUE)

#===================================================
.PVM.delhosts(hosts = slavehosts)
.PVM.delhosts(hosts = masterhost)
.PVM.halt()
#===================================================
}
}
\keyword{Mean-Variance Estimators}
\keyword{Regularization}
\keyword{Variance Stabilization}
\keyword{Normalization}
\keyword{Parallel Programming}
\keyword{High Performance Computing}


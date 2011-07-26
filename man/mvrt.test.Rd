\name{mvrt.test}
\alias{mvrt.test}
\title{Function for Computing Mean-Variance Regularized T-test Statistic and Its Significance}
\description{
    End-user function for computing MVR t-test statistic and its significance (p-value) 
    under sample group homoscedasticity or heteroscedasticity assumption. 
    
    Return an object of class "\code{mvrt.test}". Offers the option of parallel computation for 
    improved efficiency. See vignette \file{Cluster_Setup.pdf}.
}
\usage{
    mvrt.test(data, 
              obj=NULL,
              block,
              tolog = FALSE, 
              nc.min = 1, 
              nc.max = 30, 
              pval = FALSE, 
              replace = FALSE, 
              n.resamp = 100, 
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
  \item{obj}{Object of class "\code{mvr}" returned by \code{\link[MVR]{mvr}}.}
  \item{block}{\code{character} or \code{numeric} \code{vector} or \code{factor} grouping/blocking variable 
               of length the sample size. (see details).}
  \item{tolog}{\code{logical} scalar. Is the data to be log2-transformed first? Optional, defaults to \code{FALSE}.
             Note that negative or null values will be changed to 1 before taking log2-transformation.}
  \item{nc.min}{Positive \code{integer} scalar of the minimum number of clusters, defaults to 1}
  \item{nc.max}{Positive \code{integer} scalar of the maximum number of clusters, defaults to 30}
  \item{pval}{\code{logical} scalar. Shall p-values be computed? If not, \code{n.resamp} and \code{replace} will be ignored.
              If \code{FALSE} (default), t-statistic only will be computed,  
              If \code{TRUE}, exact (permutation test) or approximate (bootstrap test) p-values will be computed.}
  \item{replace}{\code{logical} scalar. Shall permutation test (default) or bootstrap test be computed?
                 If \code{FALSE} (default), permutation test will be computed with null permutation distribution,
                 If \code{TRUE}, bootstrap test will be computed with null bootstrap distribution.}
  \item{n.resamp}{Positive \code{integer} scalar of the number of resamplings to compute (default=100) by permutation or 
                  bootstsrap (see details).}
  \item{parallel}{\code{logical} scalar. Is parallel computing to be performed? Optional, defaults to \code{FALSE}.}           
  \item{conf}{\code{list} of parameters for cluster configuration.
              Inputs for R package \pkg{snow} function \code{makeCluster} (R package \pkg{snow}) for cluster setup.
              Optional, defaults to \code{NULL}. See details for usage.}
  \item{verbose}{\code{logical} scalar. Is the output to be verbose? Optional, defaults to \code{TRUE}.}
}
\details{
    Argument \code{block} is a \code{vector} or a \code{factor} grouping/blocking variable. It must be of length sample size 
    with as many different \code{character} or \code{numeric} values as the number of levels or sample groups.
    The number of sample groups must be greater or equal to 2, and all group sample sizes must be greater than 1, otherwise the program will stop.
    
    Argument \code{nc.max} currently defaults to 30. This depends (among others) on the number \eqn{p} of variables. 
    We found in our hands that this is enough for most datasets tested where \eqn{p < 10000}, and/or especially after log-transformation. 
    For higher dimensional datasets and/or without log-transformation, larger values of \code{nc.max} may be required.
    See the cluster diagnostic function \code{\link[MVR]{cluster.diagnostic}} for more details.

    Argument \code{n.resamp} is reset to \code{conf$cpus}*\code{ceiling}(\code{n.resamp}/\code{conf$cpus}) in case the Rocks cluster 
    is used (i.e. \code{conf} is non \code{NULL}), where \code{conf$cpus} denotes the total number of CPUs to be used (see below).

    To save un-necessary computations, previously computed MVR clustering can be provided through option \code{obj} (i.e. \code{obj} is fully 
    specified as a \code{\link[MVR]{mvr}} object). In this case, arguments \code{data}, \code{block}, \code{tolog}, \code{nc.min}, \code{nc.max} 
    are ignored. If \code{obj} is fully specified (i.e. an object of class "\code{mvr}" returned by \code{\link[MVR]{mvr}}), the 
    the MVR clustering provided by \code{obj} will be used for the computation of the regularized t-test statistics. 
    If \code{obj}=\code{NULL}, a MVR clustering computation for the regularized t-test statistics and/or p-values will be performed.
    
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
    
    In case p-values are desired (\code{pval}=\code{TRUE}), the use of the cluster is highly recommended. 
    It is ideal for computing embarassingly parallel tasks such as permutation or bootstrap resamplings.
    Note that in case both regularized t-test statistics and p-values are desired, in order to maximize computational efficiency and 
    avoid multiple configurations (since a cluster can only be configured and used one session at a time, which otherwise would result in a run stop), 
    the cluster configuration will only be used for the parallel computation of p-values, but not for the MVR clustering computation of the regularized t-test statistics.
}
\value{
    \item{statistic}{\code{vector}, of size the number of variables, 
                     where entries are the t-statistics values of each variable.}
    \item{p.value}{\code{vector}, of size the number of variables, 
                   where entries are the p-values (if requested, otherwise \code{NULL} value) of each variable.}
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
        \item \code{makeCluster} (R package \pkg{snow}) Simple Network of Workstations
        \item \code{eBayes} (R package \pkg{limma}) Bayesian Regularized t-test statistic \cite{Smyth, 2004}
        \item \code{samr} (R package \pkg{samr}) SAM Regularized t-test statistic \cite{Tusher et al., 2001, Storey, 2003}
        \item \code{matest} (R package \pkg{maanova}) James-Stein shrinkage estimator-based Regularized t-test statistic \cite{Cui et al., 2005}
        \item \code{ebam} (R package \pkg{siggenes}) Empirical Bayes Regularized z-test statistic \cite{Efron, 2001}
        \item \code{bayesT} Hierarchical Bayesian Regularized t-test statistic \cite{Baldi et al., 2001}
    }
}
\examples{
#================================================
# Loading the library and its dependencies
#================================================
library("MVR")
require("statmod", quietly = TRUE)
require("snow", quietly = TRUE)
require("RColorBrewer", quietly = TRUE)

#================================================
# MVR package news
#================================================
MVR.news()

#================================================
# MVR package citation
#================================================
citation("MVR")

#================================================
# Loading of the Synthetic and Real datasets 
# (see description of datasets)
#================================================
data("Synthetic", "Real", package="MVR")

#================================================
# Regularized t-test statistics (Synthetic dataset) 
# Multi-Group Assumption
# Assuming unequal variance between groups
# With option to use prior MVR clustering results
# Without computation of p-values
# Without Rocks cluster usage
#================================================
nc.min <- 1
nc.max <- 15
probs <- seq(0, 1, 0.01)
n <- 10
GF <- factor(gl(n = 2, k = n/2, len = n), 
             ordered = FALSE, 
             labels = c("G1", "G2"))
mvr.obj <- mvr(data = Synthetic, 
               block = GF, 
               tolog = FALSE, 
               nc.min = nc.min, 
               nc.max = nc.max, 
               probs = probs,
               B = 100,
               parallel = FALSE, 
               conf = NULL,
               verbose = TRUE)
mvrt.obj <- mvrt.test(obj = mvr.obj, 
                      pval = FALSE, 
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
# Regularized t-test statistics (Real dataset) 
# Multi-Group Assumption
# Assuming unequal variance between groups
# With option to use prior MVR clustering results
# With computation of p-values
# With Rocks cluster usage
#===================================================
mvrt.obj <- mvrt.test(obj = mvr.obj, 
                      pval = TRUE, 
                      replace = FALSE, 
                      n.resamp = 100, 
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
\keyword{Regularized Test Statistics}
\keyword{Parallel Programming}
\keyword{High Performance Computing}

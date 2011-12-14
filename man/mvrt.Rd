\name{mvrt}
\alias{mvrt}
\title{Mean-Variance Regularized t-Test Statistic Subroutine}
\description{
    Internal subroutine called by \code{\link[MVR]{mvrt.test}} for computing the mean-variance regularized test-statistic.
}
\usage{
    mvrt(x, obj, lev, tab, ng, def, nc.min, nc.max, parallel, conf, verbose)
}
\arguments{
  \item{x}{Input \code{matrix} with variables in columns}
  \item{obj}{Object of class "\code{mvr}" returned by \code{\link[MVR]{mvr}}.}
  \item{lev}{\code{levels} of the group/blocking \code{factor} used in mvrt.test()}
  \item{tab}{\code{numeric} scalar of the number of samples per group}
  \item{ng}{\code{numeric} scalar of the number of sample groups}
  \item{def}{\code{list} of samples indices per sample group}
  \item{nc.min}{\code{numeric} scalar of the minimum number of clusters}
  \item{nc.max}{\code{numeric} scalar of the maximum number of clusters}
  \item{parallel}{Is parallel computing to be performed? Optional, defaults to \code{FALSE}.}           
  \item{conf}{List of parameters for Rocks cluster configuration, 
              passed from \code{\link[MVR]{mvrt.test}} function for parallel computing.
              Inputs for R package \pkg{snow} function \code{makeCluster} (R package \pkg{snow}) for cluster setup.
              See details for usage.}
  \item{verbose}{Is the output to be verbose?}
}
\details{
    See details in \code{\link[MVR]{mvrt.test}}.
}
\value{
    \code{numeric} scalar of the test statistic.
}
\references{
    \itemize{
        \item Dazard J-E., Hua Xu and J. S. Rao (2011). "\emph{R package MVR for Joint Adaptive Mean-Variance Regularization and Variance Stabilization.}"
              In JSM Proceedings, Section for Statistical Programmers and Analysts. Miami Beach, FL, USA: American Statistical Association IMS - JSM. (in press).
        \item Dazard J-E. and J. S. Rao (2012). "\emph{Joint Adaptive Mean-Variance Regularization and Variance Stabilization of High Dimensional Data.}" 
              Comput. Statist. Data Anal. (to appear).
    }
}
\author{
    \itemize{
        \item Jean-Eudes Dazard, Ph.D. \email{jxd101@case.edu}
        \item Hua Xu, Ph.D. \email{hxx58@case.edu}
        \item J. Sunil Rao, Ph.D. \email{JRao@med.miami.edu}
    }
    Maintainer: Jean-Eudes Dazard, Ph.D. \email{jxd101@case.edu}
    
    URL: \url{http://proteomics.case.edu/jean_eudes_dazard.aspx}
}
\note{
    Internal subroutine of \code{\link[MVR]{mvrt.test}}, not to be called by end-user.
}
\seealso{
    \code{\link[MVR]{mvrt.test}} Mean-Variance Regularized t-Test Statistic with Significance
}
\keyword{mean-variance estimators}
\keyword{regularization}
\keyword{regularized test statistics}

\name{withinsumsq}
\alias{withinsumsq}
\title{Within-Cluster Sum of Squares Distances Subroutine}
\description{
    Wrapping subroutine around internal C subroutine for returning Monte-Carlo replicates 
    of within-cluster sum of squares distances for a given number of clusters and
    under a standard Gaussian reference distribution.
}
\usage{
    withinsumsq(n, p, B, k) 
}
\arguments{
  \item{n}{Positive \code{integer} scalar of the number of rows in the data matrix (where points to cluster are by rows (usually samples)).}
  \item{p}{Positive \code{integer} scalar of the number of columns in the data matrix (where variables are by columns).}
  \item{k}{Positive \code{integer} scalar of the fixed number of clusters.}
  \item{B}{Positive \code{integer} scalar of the number of Monte Carlo replicates of the inner loop of the gap statistic function.}
}
\details{
    None
}
\value{
    \item{lWk.mc}{\code{numeric} \code{B}-vector of Monte Carlo replicates of within-cluster sum of squares.}
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
        \item J. Sunil Rao, Ph.D. \email{JRao@med.miami.edu}
    }
    Maintainer: Jean-Eudes Dazard, Ph.D. \email{jxd101@case.edu}
    
    URL: \url{http://proteomics.case.edu/jean_eudes_dazard.aspx}
}
\note{
    Internal subroutine of \code{\link[MVR]{sim.dis}}, not to be called by end-user.
}
\seealso{
    \code{\link[MVR]{sim.dis}} Similarity Statistic.
}
\keyword{cluster}
\keyword{distance}
\keyword{dispersion}

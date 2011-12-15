\name{km.clustering}
\alias{km.clustering}
\title{Wrapper Subroutine Around C Subroutine for 'K-means' Clustering Algorithm}
\description{
    Perform 'K-means' clustering on a data matrix.
}
\usage{
    km.clustering(data, k, ns, maxiter)
}
\arguments{
  \item{data}{\code{numeric} \code{matrix} of data 
              where variables are by columns and samples to cluster are by rows.}
  \item{k}{Positive \code{integer} scalar of number of centroids to start with.}
  \item{ns}{Positive \code{integer} scalar of how many random seedings should be done.}
  \item{maxiter}{Positive \code{integer} scalar of maximum number of iterations in 'K-means' clustering algorithm (convergence criteria).}
}
\details{
    The 'K-means' clustering algorithm (current default implementation) is derived from \cite{MacQueen, 1967}. 
}
\value{
    \item{lWk}{\code{numeric} scalar of Log-transformed within cluster dispersion statistic.}
    \item{centers}{\code{numeric} \code{vector} of cluster centers.}
    \item{membership}{\code{numeric} \code{vector} of cluster membership of each variable.}
    \item{obj}{Object of class similar to the one returned by "\code{kmeans}" in R package \pkg{stats}.}
}
\references{
    \itemize{
        \item Dazard J-E., Hua Xu and J. S. Rao (2011). "\emph{R package MVR for Joint Adaptive Mean-Variance Regularization and Variance Stabilization.}"
              In JSM Proceedings, Section for Statistical Programmers and Analysts. Miami Beach, FL, USA: American Statistical Association IMS - JSM. (in press).
        \item Dazard J-E. and J. S. Rao (2012). "\emph{Joint Adaptive Mean-Variance Regularization and Variance Stabilization of High Dimensional Data.}" 
              Comput. Statist. Data Anal. (to appear).
        \item MacQueen, J. (1967). "\emph{Some methods for classification and analysis of multivariate observations}".
        In Proceedings of the Fifth Berkeley Symposium on Mathematical Statistics and Probability,
        eds L. M. Le Cam and J. Neyman, pp. 281-297. Berkeley, CA: University of California Press.
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
    Internal subroutine of \code{\link[MVR]{sim.dis}},
    and \code{\link[MVR]{MeanVarReg}}, not to be called by end-user.
}
\seealso{
    \itemize{
        \item\code{\link[MVR]{sim.dis}} Similarity Statistic.
        \item\code{\link[MVR]{MeanVarReg}} Mean-Variance Regularization Core Function.
        \item\code{\link[MVR]{withinsumsq}} Within-Cluster Sum of Squares Distances.
        \item\code{kmeans} (R package \pkg{stats}) for partition clustering in R.
    }
}
\keyword{partition clustering}
\keyword{K-means}

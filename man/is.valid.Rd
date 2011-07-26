\name{is.valid}
\alias{is.valid}
\title{Validation Subroutine to Test the Bootstrap Set of Indices}
\description{
    Internal subroutine called by end-user \code{\link[MVR]{mvrt.test}} function to validate the bootstrap set of indices 
    if a bootstrap test is undertaken in \code{\link[MVR]{mvrt.test}}. Check that the bootstrapped indices of samples 
    (from all-groups samples) are unique per sample group in a multiple sample group situation.
}
\usage{
    is.valid(x, def, ng)
}
\arguments{
  \item{x}{\code{vector} of bootstrap set of indices.}
  \item{def}{\code{list} of samples indices per sample group in original data.}
  \item{ng}{Positive \code{integer} scalar of the number of sample groups.}
}
\details{
    None
}
\value{
    \item{ok}{\code{logical} scalar, taking on value \code{TRUE} if valid and \code{FALSE} otherwise.}
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
    Internal function not to be called by end-user.
}
\seealso{
    \code{\link[MVR]{mvrt.test}} Mean-Variance Regularized t-Test Statistic with Significance.
}
\keyword{bootstrap}
\keyword{resampling with replacement}



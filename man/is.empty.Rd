\name{is.empty}
\alias{is.empty}
\title{Checks if Object is Empty}
\description{
    Internal subroutine called by end-user \code{\link[MVR]{mvr}} and \code{\link[MVR]{mvrt.test}} functions to represent the empty 
    array, matrix, or vector of zero dimension or length. Often returned by expressions and functions whose value is undefined.
}
\usage{
    is.empty(x)
}
\arguments{
  \item{x}{\code{array}, \code{matrix} or \code{vector} of any type.}
}
\details{
    None
}
\value{
    \code{logical} scalar. Returns \code{TRUE} if its argument is empty and \code{FALSE} otherwise.
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
    \code{is.null} from R package \pkg{base}.
}
\keyword{Empty Object}



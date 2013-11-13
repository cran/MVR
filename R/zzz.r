##########################################################################################################################################
#     MVR
##########################################################################################################################################
# 
# =========================================================================
#     Description:
# =========================================================================
#     Package: MVR
#     Version: 1.20.0
#     Date: 2013-11-13
#     Title: Mean-Variance Regularization
#     Description: MVR is a non-parametric method for joint adaptive 
#                  mean-variance regularization and variance stabilization 
#                  of high-dimensional data. It is suited for handling difficult 
#                  problems posed by high-dimensional multivariate datasets (p >> n paradigm), 
#                  among which are that the variance 
#                  is often a function of the mean, variable-specific estimators 
#                  of variances are not reliable, and tests statistics have 
#                  low powers due to a lack of degrees of freedom. 
#                  Key features include:
#                 (i) Normalization and/or variance stabilization of the data, 
#                 (ii) Computation of mean-variance-regularized t-statistics (F-statistics to follow), 
#                 (iii) Generation of diverse diagnostic plots, 
#                 (iv) Computationally efficient implementation using C/C++ interfacing 
#                      and an option for parallel computing to enjoy a faster and easier experience
#                      in the R environment.
#     Depends: R (>= 2.15.0), parallel, statmod
#     URL: http://www.r-project.org
#     Repository: CRAN
#     License: GPL (>= 3) | file LICENSE
#     LazyLoad: yes
#     LazyData: yes
#     Archs: i386, x64
#     
# =========================================================================
#     License:
# =========================================================================     
#     This program is a free software; you can redistribute it and/or
#     modify it under the terms of the GNU General Public License
#     as published by the Free Software Foundation; either version 2
#     of the License, or (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details. A copy of the GNU 
#     General Public is attached in the file named LICENSE.
# 
# =========================================================================
#     Acknowledgments:
# =========================================================================
#     This project was partially funded by the National Institutes of Health
#     (P30-CA043703 to J-E. DAZARD).
# 
# =========================================================================
#     Conflicts of Interest:
# =========================================================================
#     None declared.
# 
# =========================================================================
#     Authors:
# =========================================================================
#     Jean-Eudes Dazard, PhD.
#     Center for Proteomics Bioinformatics
#     Bioinformatics Division
#     Case Western Reserve University
#     10600 Euclid Avenue
#     Cleveland, OH 44106
#     email:  jxd101@case.edu
#
#     Hua Xu, PhD.
#     Center for Proteomics Bioinformatics
#     Bioinformatics Division
#     Case Western Reserve University
#     10600 Euclid Avenue
#     Cleveland, OH 44106
#     email:  huaxu77@gmail.com
# 
# 	  Alberto H. Santana, MBA, Analyst/Programmer
#     Dept. of Epidemiology and Biostatistics
#     Case Western Reserve University
#     Cleveland, OH 44106, USA.
#     email:  ahs4@case.edu
#     
# =========================================================================
#     Maintained by:
# =========================================================================
#     Jean-Eudes Dazard, PhD.
# 
##########################################################################################################################################


.onAttach <- function(libname, pkgname) {
    SSver <- read.dcf(file=system.file("DESCRIPTION", package=pkgname), 
                      fields="Version")
    packageStartupMessage("\n")
    packageStartupMessage(paste(pkgname, SSver))
    packageStartupMessage("\n")
    packageStartupMessage("\n")
    packageStartupMessage("Type MVR.news() to see new features, changes, and bug fixes.")
    packageStartupMessage("\n")
    packageStartupMessage("\n")
}

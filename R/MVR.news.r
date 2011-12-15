# *************************************************************************
#     MVR 1.10.0
# *************************************************************************
# 
#     This program is free software; you can redistribute it and/or
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
#     (P30-CA043703 to J-E.DAZARD, R01-GM085205 to J.S.RAO), and the 
#     National Science Foundation (DMS-0806076 to J.S.RAO).
# 
# =========================================================================
#     Conflicts of Interest:
# =========================================================================
#     None declared.
# 
# =========================================================================
#     Authors:
# =========================================================================
#     Jean-Eudes Dazard, Ph.D. Hua Xu, PhD.
#     Center for Proteomics Bioinformatics
#     Bioinformatics Division
#     Case Western Reserve University
#     10600 Euclid Avenue
#     Cleveland, OH 44106
#     email:  jxd101@case.edu
#     URL  :  http://proteomics.case.edu/jean_eudes_dazard.aspx
# 
#     Hua Xu, PhD.
#     Center for Proteomics Bioinformatics
#     Bioinformatics Division
#     Case Western Reserve University
#     10600 Euclid Avenue
#     Cleveland, OH 44106
#     email:  hxx58@case.edu
#     URL  :  http://proteomics.case.edu/research_associates.aspx
# 
# 	  Alberto H. Santana, MBA, Analyst/Programmer
#     Dept. of Epidemiology and Biostatistics
#     Case Western Reserve University
#     Cleveland, OH 44106, USA.
#     email:  ahs4@case.edu
#     URL  :  http://epbiwww.case.edu/index.php/people/staff/108-alberto
#     
#     J. Sunil Rao, Ph.D.
#     Deparment of Epidemiology and Public Health
#     Division of Biostatistics
#     University of Miami
#     Miami, FL 33136
#     email:  rao.jsunil@gmail.com
#     URL  :  http://www.biostat.med.miami.edu/
# 
# =========================================================================
#     Maintained by:
# =========================================================================
#     Jean-Eudes Dazard, PhD.
# 
# *************************************************************************
# *************************************************************************



MVR.news <- function(...) {
    newsfile <- file.path(system.file(package="MVR"), "NEWS")
    file.show(newsfile)
}

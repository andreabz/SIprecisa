#' Tomato yields for two fertilizer mixtures
#'
#' A dataset containing the results expressed in pounds for tomato yields obtained
#'  by a randomized experiment with two fertilizer mixtures. The variable are as
#'  follows:
#'
#' @format a dataframe with 6 rows and 3 columns:
#' \describe{
#'    \item{parameter}{the parameter observed in the experiment, the yield}
#'    \item{fertilizer}{the variable for the useed fertilizer mixture: \code{a} or \code{b}}
#'    \item{pounds}{the measured yields, in pounds}
#' }
#'
#' @name tomato_yields
#' @docType data
#' @author George E. P. Box
#' @author J. Stuart Hunter
#' @author William G. Hunter
#' @source Statistics for Experimenters, Design, Innovation and Discovery.
#'  Wiley, Second Edition, 2005. ISBN: 978-0-471-71813-0.
#'  Section 3.1, pag. 78, table 3.3
#' @keywords data
"tomato_yields"

#' F-Test data
#'
#' A dataset with 10 values divided in two groups of 5 values. The dataset is
#' provided for testing the \code{fct_test} results.
#'
#' @format a dataframe with 5 rows and 2 columns:
#' \describe{
#'    \item{group}{the grouping variable, either \code{a} or \code{b}}
#'    \item{value}{the measured value for the variable of interest}
#' }
#'
#' @name ftest_reference
#' @docType data
#' @source \url{https://support.microsoft.com/en-us/office/f-test-function-100a59e7-4108-46f8-8443-78ffacb6c0a7}.
#' @keywords data
"ftest_reference"

#' Shapiro-Wilk test data
#'
#' A dataset with 11 values of men weights expressed in pounds.
#' The dataset is provided for testing the results of \code{fct_shapiro}.
#'
#' @format a vector with 11 numerical elements.
#'
#' @name shapiro_reference
#' @docType data
#' @author S. S. Shapiro
#' @author M. B. Wilk
#' @source An analysis of variance test for normality (complete samples),
#'  Biometrika (1965), 52, 3 and 2, p. 591.
#'  Section 4 - Examples, pag. 606, Example 1.
#'  \url{http://links.jstor.org/sici?sici=0006-3444\%28196512\%2952\%3A3\%2F4\%3C591\%3AAAOVTF\%3E2.0.CO\%3B2-B}.
#' @keywords data
"shapirotest_reference"

#' Mass spectrometer measurements on a Uranium isotope
#'
#' A dataset containing the results expressed counts per seconds for mass spectrometer measurements on a Uranium isotope.
#' The variable are as follows:
#'
#' @format a vector with 8 numerical values:
#'
#' @name uranium_cps
#' @docType data
#' @author Gary L. Tietjen
#' @author Roger H. Moore
#' @source Some Grubbs-Type Statistics for the Detection of Several Outliers.
#'  Technometrics, 14(3), 1972, pp. 583-597.
#'  Also available at
#'  \url{https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h1.htm}.
#' @keywords data
"uranium_cps"

#' Observations from UNI ISO 16269-4:2019 - Section 4.3.2
#'
#' A dataset containing 20 observations for outliers detection.
#' The variable are as follows:
#'
#' @format a vector with 20 numerical values:
#'
#' @name uniiso_16269_4_432
#' @docType data
#' @author ISO/TC 69 - Applications of statistical methods
#' @source UNI ISO 16269-4:2019 - Statistical interpretation of data - Part 4:
#'  Detection and treatment of outliers. Section 4.3.2.
#'  \url{https://store.uni.com/uni-iso-16269-4-2019}.
#' @keywords data
"uniiso_16269_4_432"

#' UNI ISO 2854:1988 Section X
#'
#' A dataset with 22 values divided in two groups with 10 and 12 values, respectively.
#' The dataset is provided for testing the \code{fct_test} results.
#'
#' @format a dataframe with 12 rows and 2 columns:
#' \describe{
#'    \item{group}{the grouping variable, either \code{a} or \code{b}}
#'    \item{value}{the breaking load numerical values for the tested yarns, expressed in Newton.}
#' }
#'
#' @name uniiso_2854_x
#' @docType data
#' @source \url{https://store.uni.com/uni-iso-2854-1988}
#' @keywords data
"uniiso_2854_x"

#' UNI ISO 11352:2012 Table B.4
#'
#' A dataset with 10 values of relative differences from paired values.
#' The dataset is provided for testing the \code{fct_precision_rip} results.
#'
#' @format a dataframe with 10 rows and 1 column of numeric values named
#' {rel_diff}.
#'
#' @name uniiso_11352_b4
#' @docType data
#' @source \url{https://store.uni.com/iso-11352-2012}
#' @keywords data
"uniiso_11352_b4"

#' Manganese mean concentration values from UNI ISO 5725-4:2020, Table B.3.
#'
#' A dataset with 12 numerical values. The dataset is
#' provided for testing the \code{fct_precision} and \code{fct_trueness} results.
#'
#' @format a dataframe with 12 rows and 2 columns:
#' \describe{
#'    \item{lab}{a numeric value for the mean value for each laboratory measurements.}
#'    \item{value}{the percentage mean of the measured manganese contents provided by each laboratory}
#' }
#'
#' @name uniiso_5725_4_b3
#' @docType data
#' @source UNI ISO 5725-4:2020, Table B.3, Content level 3, pag. 20.
#' \url{https://store.uni.com/uni-iso-5725-4-2020}
#' @keywords data
"uniiso_5725_4_b3"

#' Dissolved orthophosphate concentration values from UNI ISO 11352:2012, Table B.1.
#'
#' A dataset with 30 numerical values. The dataset is
#' provided for testing the \code{fct_precision} results.
#'
#' @format a dataframe with 30 rows and 2 columns:
#' \describe{
#'    \item{id}{a numeric progressive identifier.}
#'    \item{value}{the measured orthophosphate concentration values, expressed as micromoles per liter.}
#' }
#'
#' @name uniiso_11352_b1
#' @docType data
#' @source UNI ISO 11352:2012, Table B.1, pag. 17.
#' \url{https://store.uni.com/iso-11352-2012}
#' @keywords data
"uniiso_11352_b1"

#' Manganese mean concentration values from UNI ISO 5725-4:2020, Table B.3.
#'
#' A dataset with 12 numerical values. The dataset is
#' provided for testing the \code{fct_precision} and \code{fct_trueness} results.
#'
#' @format a dataframe with 12 rows and 2 columns:
#' \describe{
#'    \item{lab}{a numeric value for the mean value for each laboratory measurements.}
#'    \item{value}{the percentage mean of the measured manganese contents provided by each laboratory}
#' }
#'
#' @name uniiso_5725_4_b3
#' @docType data
#' @source UNI ISO 5725-4:2020, Table B.3, Content level 3, pag. 20.
#' \url{https://store.uni.com/uni-iso-5725-4-2020}
#' @keywords data
"uniiso_5725_4_b3"

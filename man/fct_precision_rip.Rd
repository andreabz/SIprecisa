% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_estimate032_rip.R
\name{fct_precision_rip}
\alias{fct_precision_rip}
\title{Displays the results for the determination of precision performances calculated
from paired measurement values.}
\usage{
fct_precision_rip(data, response, significance = 0.95)
}
\arguments{
\item{data}{a \code{data.frame} or \code{data.table} with the results
relevant for testing. At least a \code{numeric} vector with the
measurements should be included.}

\item{response}{the name of a numeric vector in \code{data} with the
relative absolute differences between paired measurement values.}

\item{significance}{the level of significance for the repeatability limit
calculation. Typical values are 0.90, 0.95 or 0.99.}
}
\value{
A list with the following items:
 \describe{
   \item{alpha}{a numeric value calculated as significance + (1 - significance)/2.}
   \item{n}{the number of measurements.}
   \item{mean}{a numeric value with the mean of the values.}
   \item{rsd}{a numeric value with the relative standard deviation.}
   \item{repeatability}{a numeric value with the repeatability limit.}
 }
}
\description{
The function displays the results for the determination
of precision performances of an analytical method, based on a set of paired
measurement values.
The returned text is suitable for the {SI precisa} {shiny} app.
}
\details{
precision expressed as standard deviations, repeatability limit
and relative standard deviation (rsd) are calculated according to the Eurachem
guide - The Fitness for Purpose of Analytical Methods.
}

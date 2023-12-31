% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_estimate031_riprec.R
\name{fct_trueness_riprec}
\alias{fct_trueness_riprec}
\title{Displays the results for the determination of trueness performances}
\usage{
fct_trueness_riprec(data, response, refvalue, significance = 0.95)
}
\arguments{
\item{data}{a \code{data.frame} or \code{data.table} with the results
relevant for testing. At least a \code{numeric} vector with the
measurements should be included.}

\item{response}{the name of a numeric vector in \code{data}.}

\item{refvalue}{a reference value for the set of measurement values.}

\item{significance}{the level of significance for the repeatability limit
calculation. Typical values are 0.90, 0.95 or 0.99.}
}
\value{
A list with the following items:
 \describe{
   \item{alpha}{a numeric value calculated as significance + (1 - significance)/2.}
   \item{n}{the number of measurements.}
   \item{mean}{a numeric value with mean of the measurement values.}
   \item{lwr}{a numeric value with the lower end of the mean confidence
              interval for the measurement values.}
   \item{upr}{a numeric value with the upper end of the mean confidence
              interval for the measurement values.}
   \item{recovery}{a numeric value with the relative recovery for the
                   mean measurement values.}
   \item{bias}{a numeric value with the bias for the mean measurement values.}
   \item{bias_rel}{a numeric value with the relative bias for the mean measurement values.}
   \item{bias_rmse}{a numeric value with the root mean square error for the bias
                    of the mean measurement values.}
 }
}
\description{
The function displays the results for the determination
of trueness performances of an analytical method, based on a set of values.
 The returned text is suitable for the {SI precisa} {shiny} app.
}
\details{
trueness expressed as mean value of measurements and its confidence
interval, recovery, bias, relative bias and root mean square error for the bias
are calculated according to the Eurachem guide - The Fitness for Purpose of
Analytical Methods.
}

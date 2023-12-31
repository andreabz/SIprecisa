% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_estimate032_rip.R
\name{boxplot_rip}
\alias{boxplot_rip}
\title{Plotly boxplots for a differences of paired measurements.}
\usage{
boxplot_rip(data, response, udm)
}
\arguments{
\item{data}{input data.frame with a column named *key* with progressive integers,
a column named *rel_response* with the numeric values of the relative difference
between the paired values, and a column named *outlier* with a logical vector.}

\item{response}{a character string with the label for the response numeric variable.}

\item{udm}{a character string with the unit of measurement.}
}
\value{
A {plotly} boxplot for measurement values.
}
\description{
The function provides a simple {plotly} boxplot for differences
of paired measurement values.
}

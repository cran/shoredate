% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/target_plot.R
\name{target_plot}
\alias{target_plot}
\title{Target plot}
\usage{
target_plot(targets = NA, isobases = NA, greyscale = FALSE)
}
\arguments{
\item{targets}{Objects of class \code{sf} representing the sites to be dated. The
first column beyond geom is taken as site name.}

\item{isobases}{Spatial lines as object of class \code{sf} representing the
shoreline isobases. Defaults to isobases with a direction of 327, but
create_isobases() can be used to create isobases with other directions that
can then be passed to \code{target_plot()}.}

\item{greyscale}{Logical value indicating whether the plot should include
colours or not. Defaults to FALSE.}
}
\value{
A map displaying the location of the shoreline isobases, and, if
provided, the position of target locations represented as centroids.
}
\description{
Function to plot the centroids of one or more sites to be dated, relative to
the shoreline isobases of the employed displacement curves. The basemap is a
simplified representation of the coastline within the study area. Calling
the function without providing a target displays the map with the isobases.
This can be combined with \code{create_isobases()} to visualise isobases with a
different direction than the default of 327.
}
\examples{
# Display the background map and default isobases
target_plot()

}

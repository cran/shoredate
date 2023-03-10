% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shoredate_plot.R
\name{shoredate_plot}
\alias{shoredate_plot}
\title{Plot shoreline date}
\usage{
shoredate_plot(
  shorelinedates,
  elevation_distribution = TRUE,
  displacement_curve = TRUE,
  site_name = FALSE,
  parameters = FALSE,
  isobase_direction = FALSE,
  highest_density_region = TRUE,
  hdr_label = TRUE,
  multiplot = FALSE,
  greyscale = FALSE
)
}
\arguments{
\item{shorelinedates}{Object of class \code{shoreline_date}.}

\item{elevation_distribution}{Logical value indicating whether the gamma
distribution should be displayed. Default is TRUE.}

\item{displacement_curve}{Logical value indicating whether the displacement
curve should be displayed. Default is TRUE.}

\item{site_name}{Logical value indicating whether the name of the site should
be printed. Defaults to FALSE.}

\item{parameters}{Logical value indicating whether the parameters of the
gamma distribution should be printed. Default is FALSE.}

\item{isobase_direction}{Logical value indicating whether the direction of
the isobases should be printed. Default is FALSE.}

\item{highest_density_region}{Logical value indicating whether the 95\%
highest density region should be displayed. Defaults to TRUE.}

\item{hdr_label}{Logical value indicating whether the numeric values for the
highest density regions should be displayed. Default is TRUE.}

\item{multiplot}{Logical value indicating whether multiple dates should be
plotted individually, or be collapsed into a single plot. The only other
graphical option with \code{multiplot} set to TRUE is \code{highest_density_region}.
Default is FALSE.}

\item{greyscale}{Logical value indicating whether the plot should be in
greyscale or not. Defaults to FALSE.}
}
\value{
Plot(s) displaying shoreline dates and associated metadata.
}
\description{
Function for plotting shoreline dates along with associated metadata.
}
\details{
\code{shoredate_plot()} returns a plot displaying the provided shoreline
dates. A single plot is created for each date, where a range of settings can
be adjusted to display or hide various parameters and results. Setting the
parameter \code{multiplot} to \code{TRUE} returns a sparser version for multiple
dates, where the only option is whether or not to display the highest
density region in addition to each date. \code{multiplot} does not allow for
multiple isobase directions. Negative values denote years BCE while positive
values denote CE.
}
\examples{
# Create example point with correct coordinate reference system
target_point <- sf::st_sfc(sf::st_point(c(538310, 6544255)), crs = 32632)

# Reduce date resolution with cal_reso and elevation_reso for speed.
target_date <- shoreline_date(sites = target_point, elevation = 80,
                              elev_reso = 10,
                              cal_reso = 500)

shoredate_plot(target_date)
}

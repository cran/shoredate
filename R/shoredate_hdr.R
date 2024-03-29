#' Find the highest density region of shoreline dates
#'
#' Function to find 95% highest density region (HDR) for a provided shoreline
#'  date. Negative values denote years BCE while positive values denote CE.
#'
#' @param bce A vector holding calendar years associated with a date.
#' @param probability A vector holding the probability mass corresponding to
#'  each calendar year.
#' @param site_name A vector holding the name of the site that has been dated.
#' @param cal_reso Resolution on the calendar scale used when dating the site.
#' @param prob A numerical value between 0 and 1 indicating the probability
#'  coverage of the HDR. Defaults to `0.95`.
#'
#' @return A list holding start and end points for segments of the highest
#'  density region of a shoreline date, the weighted mean date,
#'  the probability coverage and site name.
#' @export
#'
#' @examples
#' target_point <- sf::st_sfc(sf::st_point(c(538310, 6544255)), crs = 32632)
#'
#' # Reduce date resolution with cal_reso and elevation_reso for speed
#' target_date <- shoreline_date(sites = target_point,
#'                               elevation = 80,
#'                               elev_reso = 1,
#'                               cal_reso = 400)
#'
#' # shoredate_hdr() is already called under the hood with shoreline_date(),
#' # the result of which is printed when calling the shoreline_date object
#' target_date
#'
#' # However, shoredate_hdr() can be applied separately by pulling the
#' # necessary data from the date
#' (shoredate_hdr(target_date[[1]][[1]]$date$bce,
#'                target_date[[1]][[1]]$date$probability,
#'                target_date[[1]][[1]]$site_name,
#'                target_date[[1]][[1]]$cal_reso))
shoredate_hdr <- function(bce, probability, site_name, cal_reso, prob = 0.95){

  # Code (and comments to code) to follow is taken from Parnell's Bchron
  # package unless otherwise stated:
  # https://github.com/andrewcparnell/Bchron/blob/master/R/hdr.R

  ag <- bce
  de <- probability

  wmean <- stats::weighted.mean(ag, de)

  # Put the probabilities in order of density
  o <- order(de)
  cu <- cumsum(de[o])

  # Find which ones are above the threshold
  good_cu <- which(cu > 1 - prob)
  good_ag <- sort(ag[o][good_cu])

  # Pick out the extremes of each range
  breaks <- diff(good_ag) > 1
  where_breaks <- which(diff(good_ag) > 1)
  n_breaks <- sum(breaks) + 1
  # Store output
  # [Slightly modified this to use a data frame instead of list]
  out <- data.frame()
  low_seq <- 1
  high_seq <- ifelse(length(where_breaks) == 0, length(breaks), where_breaks[1])
  for (i in 1:n_breaks) {
    out <- rbind(out, c(good_ag[low_seq], good_ag[high_seq]))
    low_seq <- high_seq + 1
    high_seq <- ifelse(i < (n_breaks - 1), where_breaks[i + 1], length(good_ag))
  }
  names(out) <- c("start", "end")

  # [Code below does not follow Parnell]
  # Collapse HDRs that adjoin on the resolution of cal_reso

  # Check if end value is cal_reso from next start value, except last row.
  # This returns indices of end values more than cal_reso from next start.
  end_indices <- which(abs(out$end -  c(utils::tail(out$start, -1),
                                        0)) != abs(cal_reso))
  end_breaks <- out$end[end_indices]

  # First select start breaks of HDRs. First row is always included, last row
  # could be, but is here made NA.
  start_breaks <- out$start[c(1, end_indices + 1)]
  # Remove the NA resulting from the last row
  start_breaks <- start_breaks[!is.na(start_breaks)]

  shdr <- list(start = start_breaks,
                     end = end_breaks,
                     prob = prob,
                     site_name = site_name,
                     weighted_mean = wmean)
  shdr
}

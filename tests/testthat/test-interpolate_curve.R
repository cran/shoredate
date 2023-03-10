test_that("undefined CRS throws error", {
  skip_on_cran()
  target_pt <- sf::st_sfc(sf::st_point(c(579570, 6582982)))
  err <- expect_error(interpolate_curve(target_pt))
  expect_equal(err$message, "Undefined coordinate reference system. This needs to be set to WGS84 / UTM zone 32N (EPSG: 32632).")
})

test_that("wrong CRS throws error and that this is printed", {
  skip_on_cran()
  target_pt <- sf::st_sfc(sf::st_point(c(579570, 6582982)), crs = 4326)
  err <- expect_error(interpolate_curve(target_pt))
  expect_equal(err$message, paste0("Target has coordinate reference system with EPSG ",
                                   sf::st_crs(target_pt)$epsg,
                                   ". This needs to be set to WGS84 / UTM zone 32N (EPSG: 32632)."))
})

test_that("if a site is located outside the limit of the study area, a warning is given", {
  skip_on_cran()
  target_point <- sf::st_sfc(sf::st_point(c(458310, 6544255)), crs = 32632)
  err <- expect_warning(interpolate_curve(target_point))
  expect_equal(err$message, "Target location is not within the study area for which the method was derived.")
})

test_that("the IDW works for a point on an isobase", {
  skip_on_cran()
  target_point <- sf::st_sfc(sf::st_point(c(579569.4, 6582981)), crs = 32632)
  expect_type(interpolate_curve(target_point), "list")
})

test_that("progress is printed with verbose = TRUE", {
  skip_on_cran()
  target_point <- sf::st_sfc(sf::st_point(c(579569.4, 6582981)), crs = 32632)
  expect_snapshot(interpolate_curve(target_point, verbose = TRUE))
})

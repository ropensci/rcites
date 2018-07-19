context("helper function")


test_that("basic functioning", {
  expect_equal(sppplus_baseurl(), "https://api.speciesplus.net/api/v1/")
  expect_equal(sppplus_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  expect_message(sppplus_login(""), "no token provided")
})

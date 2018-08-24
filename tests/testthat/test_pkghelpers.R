context("helper function")


test_that("basic functioning", {
  expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
  expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  expect_message(set_token(""), "no token provided")
})

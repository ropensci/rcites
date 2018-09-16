context("Helper functions")


## General helpers
test_that("General helpers", {
  expect_true(identical(rcites_timestamp("2017-01-01"), "2017-01-01T00:00:00"))
  expect_true(is.null(rcites_lang("en")))
  expect_true(identical(rcites_lang("fr"), "language=fr"))
  expect_error(rcites_lang("wrong"))
  expect_true(is.null(rcites_scope("current")))
  expect_true(identical(rcites_scope("all"), "scope=all"))
  expect_error(rcites_scope("wrong"))
  expect_error(rcites_checkid("1wrong234"))
})


## Base URL
pag <- list(per_page = 500, total_entries = 501)

test_that("Base URL", {
  expect_equal(rcites_numberpages(pag), 2)
  expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
  expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  expect_message(set_token(""), "no token provided")
})


## Outputs helper
ls_ex <- rcites_null_to_na(list("A", list("A", NULL)))

test_that("Outputs helpers", {
  expect_true(is.na(ls_ex[[2L]][[2L]]))
})

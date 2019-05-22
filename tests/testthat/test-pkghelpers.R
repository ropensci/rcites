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
  expect_warning(rcites_checkid("1wrong234"))
})


## Base URL
pag <- list(per_page = 500, total_entries = 501)

test_that("Base URL", {
  expect_equal(rcites_numberpages(pag), 2)
  expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
  expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  expect_error(set_token(""), "No token has been provided.")
})


## Outputs helpers
ls_ex <- rcites_null_to_na(list("A", list("A", NULL)))
df1 <- data.frame(is_current = c(1, 0), wrong = letters[1:2])
res1 <- rcites_to_logical(df1)

test_that("Outputs helpers", {
  expect_true(is.na(ls_ex[[2L]][[2L]]))
  expect_true(all(res1$is_current == c(TRUE, FALSE)))
})

## Prin helpers
str <- paste(letters[1:26], collapse = "")
str2 <- paste(letters[1:25], collapse = "")
rcites_print_shorten(str)
test_that("Print helpers", {
  expect_equal(rcites_print_shorten(str),
    paste0(substring(str, 1, 20), " [truncated]"))
  expect_equal(rcites_print_shorten(str2), str2)
  expect_equal(rcites_print_shorten(str, 4), "abcd [truncated]")
  expect_output(rcites_print_df(data.frame(id = 1)), "  id\\n1  1")
})

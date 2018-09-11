context("Helper functions")


## General helpers

test_that("General helpers", {
  expect_true(identical(rcites_timestamp("2017-01-01"), "2017-01-01T00:00:00"))
  expect_true(is.null(rcites_lang("en")))
  expect_true(identical(rcites_lang("fr"), "language=fr"))
  expect_error(rcites_lang("wr"))
  expect_true(is.null(rcites_scope("current")))
  expect_true(identical(rcites_scope("all"), "scope=all"))
  expect_error(rcites_scope("wr"))
})


pag <- list(per_page = 500, total_entries = 501)

test_that("base URL", {
  expect_equal(rcites_numberpages(pag), 2)
  expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
  expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  expect_message(set_token(""), "no token provided")
})

# to be tested
# as.data.frame(do.call(rbind, res$taxon_concepts[[1]][[10]]))
# q_url <- "https://api.speciesplus.net/api/v1/taxon_concepts.json?taxonomy=CMS&page=1&per_page=500"
# q_res <- rcites_res(q_url, token)
# np <- rcites_numberpages(q_res$pagination)
# out <- rcites_autopagination(q_url, np, 500, token)
# gsub("https://api.speciesplus.net/api/v1/taxon_concepts.json?&page=12&per_page=500",
# pat = "page=[[:digit:]]+\\&per_page=[[:digit:]]+$", rep = "")
#

## Output helper

ls_ex <- rcites_null_to_na(list("A", list("A", NULL)))


test_that("base URL", {
  expect_true(is.na(ls_ex[[2L]][[2L]]))
  # expect_equal(rcites_numberpages(pag), 2)
  # expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
  # expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  # expect_message(set_token(""), "no token provided")
})

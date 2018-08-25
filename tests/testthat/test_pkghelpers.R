context("helper function")


pag <- list(per_page = 500, total_entries = 501)

test_that("basic functioning", {
  expect_equal(rcites_numberpages(pag), 2)
  expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
  expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
  expect_message(set_token(""), "no token provided")
})

# to be tested
# as.data.frame(do.call(rbind, res$taxon_concepts[[1]][[10]]))

context("helper function")

## General helpers

test_that("basic functioning", {
  expect_equal(rcites_url(tx_id), "https://api.speciesplus.net/api/v1/4521")
})




# pag <- list(per_page = 500, total_entries = 501)

# test_that("basic functioning", {
#   expect_equal(rcites_numberpages(pag), 2)
#   expect_equal(rcites_baseurl(), "https://api.speciesplus.net/api/v1/")
#   expect_equal(rcites_url("extra"), "https://api.speciesplus.net/api/v1/extra")
#   expect_message(set_token(""), "no token provided")
# })

# to be tested
# as.data.frame(do.call(rbind, res$taxon_concepts[[1]][[10]]))
# q_url <- "https://api.speciesplus.net/api/v1/taxon_concepts.json?taxonomy=CMS&page=1&per_page=500"
# q_res <- rcites_res(q_url, token)
# np <- rcites_numberpages(q_res$pagination)
# out <- rcites_autopagination(q_url, np, 500, token)
# gsub("https://api.speciesplus.net/api/v1/taxon_concepts.json?&page=12&per_page=500",
# pat = "page=[[:digit:]]+\\&per_page=[[:digit:]]+$", rep = "")
#

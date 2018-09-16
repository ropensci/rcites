context("Wrong token")

token <- "wrong"
msg <- "Unauthorized (HTTP 401)"
q_url <- rcites_url(paste0("taxon_concepts/", tx_id, "/distributions.json"))

test_that("expected url", {
  expect_equal(q_url, "https://api.speciesplus.net/api/v1/taxon_concepts/4521/distributions.json")
})

test_that("expected errors", {
  ut_pause()
  expect_error(rcites_res(q_url, token), msg, fixed = TRUE)
  ut_pause()
  expect_error(spp_taxonconcept(query_taxon = tx_nm, token = token), msg, fixed = TRUE)
})

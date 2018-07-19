context("wong token")

token <- "wrong"
msg <- "Unauthorized (HTTP 401)"
q_url <- sppplus_url(paste0("taxon_concepts/", tx_id, "/distributions.json"))

test_that("expected url", {
  expect_equal(q_url, "https://api.speciesplus.net/api/v1/taxon_concepts/4521/distributions.json")
})

test_that("expected errors", {
  ut_pause()
  expect_error(sppplus_res(q_url, token), msg, fixed = TRUE)
  ut_pause()
  expect_error(sppplus_taxonconcept(query_taxon = 'Loxodonta africana', token = token), msg, fixed = TRUE)
})

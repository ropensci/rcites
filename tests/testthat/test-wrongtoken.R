context("Wrong token")

skip_on_cran()
skip_if_no_auth()


token <- "wrong"
msg <- "Unauthorized (HTTP 401)"
q_url <- rcites_url(paste0("taxon_concepts/", tx_id, "/distributions.json"))

test_that("expected errors", {
  ut_pause()
  expect_error(rcites_res(q_url, token), class = "http_401")
  ut_pause()
  expect_error(spp_taxonconcept(query_taxon = tx_nm, token = token), class = "http_401")
  ut_pause()
  # testing extra parameters
  qurl <- rcites_taxonconcept_request(tx_nm, "CITES", FALSE, 1, 500, NULL, NULL)
  expect_error(rcites_res(qurl, rcites_getsecret(),  httr::timeout(1)))
})

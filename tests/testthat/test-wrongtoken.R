context("wong token")

token <- "wrong"

test_that("expected errors", {
  expect_error(sppplus_taxonconcept(query_taxon = 'Loxodonta africana', token), 'Unauthorized (HTTP 401)', fixed = TRUE)
  expect_error(taxon_cites_legislation(tax_id = '4521', token), 'Unauthorized (HTTP 401)', fixed = TRUE)
})

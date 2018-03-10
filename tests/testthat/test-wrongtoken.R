context("wong token")

token <- "wrong"
Sys.sleep(4)
msg <- "Unauthorized (HTTP 401)"

test_that("expected errors", {
  expect_error(sppplus_taxonconcept(query_taxon = 'Loxodonta africana', token = token), msg, fixed = TRUE)
  expect_error(taxon_cites_legislation(tax_id = '4521', token = token), msg, fixed = TRUE)
})

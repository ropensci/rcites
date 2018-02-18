token <- "wrong"

test_that("expected errors", {
  expect_error(taxon_cites_legislation(token, tax_id = '4521', type = "wrongtoo"), 'all(type %in% c("listings", "quotas", "suspensions")) is not TRUE', fixed = TRUE)
  expect_error(taxon_cites_legislation(token, tax_id = '4521'), 'Unauthorized (HTTP 401)', fixed = TRUE)
})

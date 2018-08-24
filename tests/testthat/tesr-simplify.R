context("simpify")

skip_on_cran()
skip_if_no_auth()

res1a <- spp_eu_legislation(taxon_id = '3210')
res1b <- copy(res1a)
rcites_simplify(res1b$eu_listing)
res2 <- spp_eu_legislation(taxon_id = '3210', simplify = TRUE)


test_that("simplify outputs - check", {
  expect_error(rcites_simplify("wrong"), 'class(x) %in% "data.table" is not TRUE', fixed = TRUE)
  expect_true(!identical(res1a, res2))
  expect_true(identical(res1b, res2))
})

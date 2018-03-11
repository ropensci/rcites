context("taxon concept")

skip_on_cran()
skip_if_no_auth()

Sys.sleep(1)
res1 <- sppplus_taxonconcept(query_taxon = tx_nm)
Sys.sleep(1)
res2 <- sppplus_taxonconcept(query_taxon = tx_nm, appendix_only = TRUE)
nm1 <- c("all", "synonyms", "common_names", "higher_taxa")

test_that("expected classes", {
  expect_equal(class(res1), "list")
  expect_true(all(class(res1$all) == cl_dt))
  expect_true(all(class(res1$synonyms) == cl_dt))
  expect_true(all(class(res1$higher_taxa) == cl_dt))
  expect_true(all(class(res1$common_names) == cl_dt))
  expect_true(all(class(res2) == cl_dt))
})

test_that("expected output names", {
  expect_true(all(names(res1) == nm1))
  expect_true(all(names(res2) == c("id", "full_name", "cites_listing")))
})

test_that("expected values", {
  expect_equal(res2$id, 4521)
  expect_equal(res2$full_name, tx_nm)
})

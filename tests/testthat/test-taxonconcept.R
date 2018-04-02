context("taxon concept")

skip_on_cran()
skip_if_no_auth()

ut_pause()
res1 <- sppplus_taxonconcept(query_taxon = tx_nm)
ut_pause()
res2 <- sppplus_taxonconcept(query_taxon = tx_nm, appendix_only = TRUE)
nm1 <- c("id", "full_name", "author_year", "rank", "name_status", "updated_at", "active", "cites_listing")
nm2 <- c("all", "synonyms", "common_names", "higher_taxa")
ut_pause()
res_null <- suppressWarnings(sppplus_taxonconcept(query_taxon = "Homo sapiens"))
ut_pause()
res3 <- sppplus_taxonconcept(query_taxon = "Amazilia versicolor")


test_that("expected classes", {
  expect_equal(class(res1), "list")
  expect_true(all(class(res1$all) == cl_dt))
  expect_true(all(class(res1$synonyms) == cl_dt))
  expect_true(all(class(res1$higher_taxa) == cl_dt))
  expect_true(all(class(res1$common_names) == cl_dt))
  expect_true(all(class(res2) == cl_dt))
  expect_true(is.null(res_null))
  ut_pause()
  expect_warning(sppplus_taxonconcept(query_taxon = "Homo sapiens"), "Taxon not listed.", fixed = TRUE)
})

test_that("expected output names", {
  expect_true(all(names(res1) == nm2))
  expect_true(all(names(res1$all) == nm1))
  expect_true(all(names(res2) == nm1))
})

test_that("expected values", {
  expect_equal(res2$id, tx_id)
  expect_equal(res2$full_name, tx_nm)
  expect_true(all(dim(res3$all) == c(2, 8)))
})

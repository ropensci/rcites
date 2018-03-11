context("references")

skip_on_cran()
skip_if_no_auth()

ut_pause()
res1 <- taxon_references(tax_id = tx_id)
ut_pause()
res2 <- taxon_references(tax_id = tx_id, type = 'taxonomic')
ut_pause()
res3 <- taxon_references(tax_id = tx_id, simplify = T)


test_that("expected output classes", {
  expect_equal(class(res1), "list")
  expect_equal(class(res2), "list")
  expect_equal(class(res3), "list")
  expect_true(all(class(res1$taxonomic) == cl_dt))
  expect_equal(class(res1$taxonomic$id), "list")
  expect_equal(class(res3$taxonomic$id), "integer")
})

test_that("expected output names", {
  expect_true(all(names(res1) == c("taxonomic", "distribution")))
  expect_true(names(res2) == "taxonomic")
  expect_true(all(names(res1$taxonomic) == c("id", "citation", "is_standard")))
  expect_true(all(names(res1$distribution) == c("name", "reference")))
  expect_true(all(names(res1$taxonomic) == names(res2$taxonomic)))
})

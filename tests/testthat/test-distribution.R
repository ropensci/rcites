context("distribution")

skip_on_cran()
skip_if_no_auth()


ut_pause()
res1 <- taxon_distribution(tax_id = tx_id)
ut_pause()
res2 <- taxon_distribution(tax_id = '4521', collapse_tags = ' + ', simplify = T)


test_that("expected output classes", {
  expect_equal(class(res1), cl_dt)
  expect_equal(class(res2), cl_dt)
  expect_true(all(class(res1$id) == "list"))
  expect_true(all(class(res2$id) == "integer"))
  expect_true(all(class(res1$references) == "list"))
  expect_true(all(class(res2$references) == "list"))
})

test_that("expected output names", {
  expect_true(all(names(res1) == c("id", "iso_code2", "name", "tags", "type", "references")))
})

test_that("expected output", {
  expect_true(!any(grepl(unlist(res1$tags), pattern = " \\+ ")))
  expect_true(any(grepl(unlist(res2$tags), pattern = " \\+ ")))
})

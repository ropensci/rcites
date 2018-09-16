context("references")

skip_on_cran()
skip_if_no_auth()

res1 <- spp_references(taxon_id = tx_id)
res2 <- spp_references(taxon_id = tx_id, raw = TRUE)
nm1 <- c("id", "citation", "is_standard")
ut_pause()

test_that("expected output classes", {
  expect_equal(class(res1), "spp_refs")
  expect_equal(class(res1[1L]), "list")
  expect_true(all(unlist(lapply(res1, function(x) all(class(x) == cl_df)))))
  expect_true(all(names(res1$references == nm1)))
  expect_equal(class(res2), cl_raw)
})

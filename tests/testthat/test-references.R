context("references")

skip_on_cran()
skip_if_no_auth()
ut_pause()

res1 <- spp_references(taxon_id = tx_id)
res1b <- spp_references(taxon_id = tx_id2, verbose = FALSE)
res2 <- spp_references(taxon_id = tx_id, raw = TRUE, verbose = FALSE)
nm1 <- c("id", "citation", "is_standard")
ut_pause()

test_that("expected output classes", {
  expect_s3_class(res1, "spp_refs")
  expect_true(is(res1[1L], "list"))
  expect_true(all(unlist(lapply(res1, function(x) is_cl_df(x)))))
  expect_true(all(names(res1$references == nm1)))
  expect_true(is_cl_rw(res2))
})


ut_pause(2)
res3 <- spp_references(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
ut_pause()
res4 <- spp_references(taxon_id = c(tx_id, tx_id2), raw = TRUE, verbose = FALSE)
test_that("refs_multi outputs", {
  expect_s3_class(res3, "spp_refs_multi")
  expect_true(is_cl_df(res3$references))
  expect_equal(nrow(res3$references),
    nrow(res1$references) + nrow(res1b$references))
  expect_identical(unique(res3$references$taxon_id),  c(tx_id, tx_id2))
  expect_true(is_cl_rm(res4))
  expect_true(is_cl_rw(res4[[1L]]))
  expect_equal(length(res4), 3)
  expect_identical(res4$taxon_id, c(tx_id, tx_id2))
})
ut_pause()

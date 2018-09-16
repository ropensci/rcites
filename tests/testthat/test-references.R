context("references")

skip_on_cran()
skip_if_no_auth()

res1 <- spp_references(taxon_id = '4521')
res2 <- spp_references(taxon_id = '4521', raw = TRUE)
ut_pause()

test_that("expected output classes", {
  expect_equal(class(res1), "spp_refs")
  expect_equal(class(res1[1L]), "list")
  expect_true(all(unlist(lapply(res1, function(x) all(class(x) == cl_df)))))
})
#
# test_that("expected output names", {
#   expect_true(all(names(res1) == c("taxonomic", "distribution")))
#   expect_true(names(res2) == "taxonomic")
#   expect_true(all(names(res1$taxonomic) == c("id", "citation", "is_standard")))
#   expect_true(all(names(res1$distribution) == c("name", "reference")))
#   expect_true(all(names(res1$taxonomic) == names(res2$taxonomic)))
# })

context("Distribution")

skip_on_cran()
skip_if_no_auth()


res1 <- spp_distributions(taxon_id = '4521')
res2 <- spp_distributions(taxon_id = '4521', raw = TRUE)
res3 <- spp_distributions(taxon_id = '4521', language = "fr")
res4 <- spp_distributions(taxon_id = '4521', language = "es")
ut_pause(5)


lang_GQ <- c("Equatorial Guinea", "Guinée équatoriale", "Guinea Ecuatorial")
lang_en <- lang_GQ %in% res1$distributions$name
lang_fr <- lang_GQ %in% res3$distributions$name
lang_es <- lang_GQ %in% res4$distributions$name

test_that("Expected classes", {
  expect_equal(class(res1), "spp_distr")
  expect_equal(class(res1[1L]), "list")
  expect_true(all(unlist(lapply(res1, function(x) all(class(x) == cl_df)))))
  expect_true(all(class(res2) == cl_raw))
  expect_true(all(names(res1[[1L]]) == c("id", "iso_code2", "name", "type", "tags")))
  expect_true(all(names(res1[[2L]]) == c("id", "reference")))
})

test_that("Language", {
  expect_true(all(lang_en == c(TRUE, FALSE, FALSE)))
  expect_true(all(lang_fr == c(FALSE, TRUE, FALSE)))
  expect_true(all(lang_es == c(FALSE, FALSE, TRUE)))
})

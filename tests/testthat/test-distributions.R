context("Distributions")

skip_on_cran()
skip_if_no_auth()
ut_pause()

res1 <- spp_distributions(taxon_id = tx_id)
res1b <- spp_distributions(taxon_id = tx_id2, verbose = FALSE)
res2 <- spp_distributions(taxon_id = tx_id, raw = TRUE, verbose = FALSE)
res3 <- spp_distributions(taxon_id = tx_id, language = "fr", verbose = FALSE)
res4 <- spp_distributions(taxon_id = tx_id, language = "es", verbose = FALSE)

lang_GQ <- c("Equatorial Guinea", "Guinée équatoriale", "Guinea Ecuatorial")
lang_en <- lang_GQ %in% res1$distributions$name
lang_fr <- lang_GQ %in% res3$distributions$name
lang_es <- lang_GQ %in% res4$distributions$name

test_that("Expected classes", {
  expect_equal(class(res1), "spp_distr")
  expect_equal(class(res1[1L]), "list")
  expect_true(all(unlist(lapply(res1, function(x) all(class(x) == cl_df)))))
  expect_true(all(class(res2) == cl_raw))
  vc_ch <- c("id", "iso_code2", "name", "type", "tags")
  expect_true(all(names(res1[[1L]]) == vc_ch))
  expect_true(all(names(res1[[2L]]) == c("id", "reference")))
  expect_null(print(res1))
  expect_null(print(res2))
})

test_that("Language", {
  expect_true(all(lang_en == c(TRUE, FALSE, FALSE)))
  expect_true(all(lang_fr == c(FALSE, TRUE, FALSE)))
  expect_true(all(lang_es == c(FALSE, FALSE, TRUE)))
})


ut_pause(2)
res5 <- spp_distributions(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
ut_pause()
res6 <- spp_distributions(taxon_id = c(tx_id, tx_id2), raw = TRUE,
  verbose = FALSE)
test_that("distr_multi outputs", {
  expect_equal(class(res5), "spp_distr_multi")
  expect_equal(class(res5$distributions), cl_df)
  expect_equal(nrow(res5$distributions),
    nrow(res1$distributions) + nrow(res1b$distributions))
  expect_identical(unique(res5$distributions$taxon_id), c(tx_id, tx_id2))
  expect_identical(class(res6), cl_raw_multi)
  expect_equal(class(res6[[1L]]), cl_raw)
  expect_equal(length(res6), 3)
  expect_identical(res6$taxon_id, c(tx_id, tx_id2))
})
ut_pause()

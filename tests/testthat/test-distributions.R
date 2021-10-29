context("Distributions")

lang_GQ <- c("Equatorial Guinea", "Guinée équatoriale", "Guinea Ecuatorial")


test_that("spp_distributions() default works", {
  vcr::use_cassette("spp_distributions_def", {
    res <- spp_distributions(taxon_id = tx_id)
  })  
  expect_equal(class(res), "spp_distr")
  expect_equal(class(res[1L]), "list")
  expect_true(all(unlist(lapply(res, function(x) all(class(x) == cl_df)))))
  expect_identical(lang_GQ %in% res$distributions$name, c(TRUE, FALSE, FALSE))
  # expect_null(print(res))
})

test_that("spp_distributions() verbose mode works", {
  vcr::use_cassette("spp_distributions_ver", {
    expect_silent(res <- spp_distributions(taxon_id = tx_id, verbose = FALSE))
  })  
})

test_that("spp_distributions() raw mode works", {
  vcr::use_cassette("spp_distributions_raw", {
    res <- spp_distributions(taxon_id = tx_id, raw = TRUE, verbose = FALSE)
  })  
  expect_true(all(class(res) == cl_raw))
  # expect_null(print(res))
})


test_that("spp_distributions() language works", {
  vcr::use_cassette("spp_distributions_lan", {
    res1 <- spp_distributions(taxon_id = tx_id, language = "fr", 
      verbose = FALSE)
    res2 <- spp_distributions(taxon_id = tx_id, language = "es", 
      verbose = FALSE)
  })  
  expect_identical(lang_GQ %in% res1$distributions$name, c(FALSE, TRUE, FALSE))
  expect_identical(lang_GQ %in% res2$distributions$name, c(FALSE, FALSE, TRUE))
})

test_that("spp_distributions() batch mode works", {
  vcr::use_cassette("spp_distributions_bat", {
    res1 <- spp_distributions(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
    res2 <- spp_distributions(taxon_id = c(tx_id, tx_id2), raw = TRUE,
      verbose = FALSE)
  })  
  expect_identical(unique(res1$distributions$taxon_id), c(tx_id, tx_id2))
  expect_equal(class(res1), "spp_distr_multi")
  expect_identical(class(res2), cl_raw_multi)
  expect_equal(length(res2), 3)
  expect_identical(res2$taxon_id, c(tx_id, tx_id2))
})

# taxon with only one distribution
test_that("spp_distributions() edge case: one distribution", {
  vcr::use_cassette("spp_distributions_one", {
    res <- spp_distributions("10000", verbose = FALSE)
  })  
  expect_equal(dim(res$distribution)[1], 1)
})


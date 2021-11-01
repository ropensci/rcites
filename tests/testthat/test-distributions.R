lang_GQ <- c("Equatorial Guinea", "Guinée équatoriale", "Guinea Ecuatorial")

test_that("spp_distributions() defaults work", {
  vcr::use_cassette("spp_distributions_def", {
    res <- spp_distributions(taxon_id = tx_id)
  })  
  expect_s3_class(res, "spp_distr")
  expect_type(res[1L], "list")
  expect_true(all(unlist(lapply(res, function(x) is_cl_df(x)))))
  expect_identical(lang_GQ %in% res$distributions$name, c(TRUE, FALSE, FALSE))
  expect_snapshot(print(res))
})

test_that("spp_distributions() works when no info available", {
  vcr::use_cassette("spp_distributions_noi", {
    expect_warning(res <- spp_distributions(taxon_id = 0))
  })  
  expect_snapshot(print(res))
})

test_that("spp_distributions() raw mode works", {
  vcr::use_cassette("spp_distributions_raw", {
    expect_silent(res1 <- spp_distributions(taxon_id = tx_id, raw = TRUE, verbose = FALSE))
    expect_warning(res2 <- spp_distributions(taxon_id = 0, raw = TRUE, verbose = FALSE))
  })  
  expect_true(is_cl_rw(res1))
  expect_true(is_cl_rw(res2))
  expect_equal(
    res2$error$message,
    "We are sorry but an error occurred processing your request"
  )
  # expect_snapshot(print(res1))
})

test_that("spp_distributions() language works", {
  vcr::use_cassette("spp_distributions_lan", {
    res1 <- spp_distributions(taxon_id = tx_id, language = "fr", 
      verbose = FALSE)
  })  
  expect_identical(lang_GQ %in% res1$distributions$name, c(FALSE, TRUE, FALSE))
})

test_that("spp_distributions() batch mode works", {
  vcr::use_cassette("spp_distributions_bat", {
    res1 <- spp_distributions(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
    res2 <- spp_distributions(taxon_id = c(tx_id, tx_id2), raw = TRUE,
      verbose = FALSE)
  })  
  expect_identical(unique(res1$distributions$taxon_id), c(tx_id, tx_id2))
  expect_s3_class(res1, "spp_distr_multi")
  expect_true(is_cl_rm(res2))
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


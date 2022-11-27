m_ci <- c("cites_listings", "cites_quotas", "cites_suspensions")
nm_eu <- c("eu_listings", "eu_decisions")

suppressMessages({
  test_that("spp_cites_legislation() defaults work", {
    vcr::use_cassette("spp_cites_legislation_def", {
      res <- spp_cites_legislation(taxon_id = tx_id)
    })
    expect_s3_class(res, "spp_cites_leg")
    expect_type(res[1L], "list")
    expect_true(all(unlist(lapply(res, function(x) is_cl_df(x)))))
    expect_true(all(res$cites_listings$is_current))
    expect_type(res$cites_suspensions$applies_to_import, "logical")
    expect_type(res$cites_quotas$public_display, "logical")
    expect_true("Guinea" %in% res$cites_suspensions$geo_entity.name)
    expect_snapshot(print(res))
  })

  test_that("spp_cites_legislation() raw mode works", {
    vcr::use_cassette("spp_cites_legislation_raw", {
      expect_silent(res1 <- spp_cites_legislation(
        taxon_id = tx_id,
        raw = TRUE, verbose = FALSE
      ))
      expect_warning(res2 <- spp_cites_legislation(
        taxon_id = 0,
        raw = TRUE, verbose = FALSE
      ))
    })
    expect_true(is_cl_rw(res1))
    expect_true(is_cl_rw(res2))
    expect_equal(
      res2$error$message,
      "We are sorry but an error occurred processing your request"
    )
  })

  test_that("spp_cites_legislation() scope & language works", {
    vcr::use_cassette("spp_cites_legislation_sco", {
      res <- spp_cites_legislation(
        taxon_id = tx_id, scope = "all",
        language = "fr", verbose = FALSE
      )
    })
    expect_s3_class(res, "spp_cites_leg")
    expect_true(!all(res$cites_listings$is_current))
    expect_true("Guinée" %in% res$cites_suspensions$geo_entity.name)
  })

  test_that("spp_eu_legislation() defaults works", {
    vcr::use_cassette("spp_eu_legislation_def", {
      res <- spp_eu_legislation(taxon_id = tx_id)
    })
    expect_equal(nrow(res$eu_listings), 2)
    expect_true("Namibia" %in% res$eu_decisions$geo_entity.name)
    expect_s3_class(res, "spp_eu_leg")
    expect_type(res[1L], "list")
    expect_true(all(unlist(lapply(res, function(x) is_cl_df(x)))))
    expect_true(all(res$eu_listings$is_current))
  })

  test_that("spp_eu_legislation() raw mode works", {
    vcr::use_cassette("spp_eu_legislation_raw", {
      expect_silent(res1 <- spp_eu_legislation(
        taxon_id = tx_id,
        raw = TRUE, verbose = FALSE
      ))
      expect_warning(res2 <- spp_eu_legislation(
        taxon_id = 0,
        raw = TRUE, verbose = FALSE
      ))
    })
    expect_true(is_cl_rw(res1))
    expect_true(is_cl_rw(res2))
    expect_equal(
      res2$error$message,
      "We are sorry but an error occurred processing your request"
    )
  })

  test_that("spp_cites_legislation() scope & lang works", {
    vcr::use_cassette("spp_eu_legislation_sco", {
      res <- spp_eu_legislation(
        taxon_id = tx_id, scope = "all",
        language = "fr", verbose = FALSE
      )
    })
    expect_s3_class(res, "spp_eu_leg")
    expect_true(!all(res$eu_listings$is_current))
    expect_true("Namibie" %in% res$eu_decisions$geo_entity.name)
  })

  test_that("spp_cites_legislation() batch mode works", {
    vcr::use_cassette("spp_cites_legislation_bat", {
      res <- spp_cites_legislation(
        taxon_id = c(tx_id, tx_id2, "8094"),
        verbose = FALSE
      )
    })
    expect_s3_class(res, "spp_cites_leg_multi")
    expect_true(is_cl_df(res$cites_listings))
    expect_identical(
      unique(res$cites_listings$taxon_id),
      c(tx_id, tx_id2)
    )
    # to be checked see #59
    expect_equal(length(res), 3)
  })

  test_that("spp_cites_legislation() batch mode works", {
    vcr::use_cassette("spp_eu_legislation_bat", {
      res <- spp_eu_legislation(
        taxon_id = c(tx_id, tx_id2),
        verbose = FALSE
      )
    })
    expect_s3_class(res, "spp_eu_leg_multi")
    expect_true(is_cl_df(res$eu_listings))
    expect_identical(unique(res$eu_listings$taxon_id), c(tx_id, tx_id2))
    expect_equal(length(res), 2)
    # to be checked see #59
  })
})

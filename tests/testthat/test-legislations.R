context("Legislations")

skip_on_cran()
skip_if_no_auth()
ut_pause()
#
res1 <- spp_cites_legislation(taxon_id = tx_id)
res1b <- spp_cites_legislation(taxon_id = tx_id2, verbose = FALSE)
res2 <- spp_cites_legislation(taxon_id = tx_id, raw = TRUE, verbose = FALSE)
ut_pause()
res3 <- spp_cites_legislation(taxon_id = tx_id, scope = 'all', verbose = FALSE)
res4 <- spp_cites_legislation(taxon_id = tx_id, language = 'fr',
  verbose = FALSE)
ut_pause()
#
res5 <- spp_eu_legislation(taxon_id = tx_id, verbose = FALSE)
res5b <- spp_eu_legislation(taxon_id = tx_id2, verbose = FALSE)
res6 <- spp_eu_legislation(taxon_id = tx_id, raw = TRUE, verbose = FALSE)
ut_pause()
res7 <- spp_eu_legislation(taxon_id = tx_id, scope = 'all', verbose = FALSE)
res8 <- spp_eu_legislation(taxon_id = tx_id, language = 'fr', verbose = FALSE)
ut_pause()


#
nm_ci <- c("cites_listings", "cites_quotas", "cites_suspensions")
nm_eu <- c("eu_listings",  "eu_decisions")

test_that("Expected classes", {
  expect_equal(class(res1), "spp_cites_leg")
  expect_equal(class(res1[1L]), "list")
  expect_true(all(unlist(lapply(res1, function(x) all(class(x) == cl_df)))))
  #
  expect_equal(class(res5), "spp_eu_leg")
  expect_equal(class(res5[1L]), "list")
  expect_true(all(unlist(lapply(res5, function(x) all(class(x) == cl_df)))))
  #
  expect_true(all(class(res2) == cl_raw))
  expect_true(all(class(res6) == cl_raw))
  #
})
#

test_that("logical", {
 expect_true(all(res1$cites_listings$is_current))
 expect_true(!all(res3$cites_listings$is_current))
 expect_true(all(res5$eu_listings$is_current))
 expect_true(all(res5b$eu_listings$is_current))
 expect_true(!all(res7$eu_listings$is_current))
 #
 expect_true(class(res1$cites_suspensions$applies_to_import) == "logical")
 expect_true(class(res1$cites_quotas$public_display) == "logical")
})

test_that("Expected number of entries", {
 expect_equal(nrow(res5$eu_listings), 2)
 expect_equal(nrow(res5b$eu_listings), 1)
})



lang_en_ci <- c("Guinea", "Guinée") %in% res1$cites_suspensions$geo_entity.name
lang_fr_ci <- c("Guinea", "Guinée") %in% res4$cites_suspensions$geo_entity.name
#
lang_en_eu <- c("Ethiopia", "Ethiopie") %in% res5$eu_decisions$geo_entity.name
lang_fr_eu <- c("Ethiopia", "Ethiopie") %in% res8$eu_decisions$geo_entity.name

test_that("Language", {
  expect_true(all(lang_en_ci == c(TRUE, FALSE)))
  expect_true(all(lang_fr_ci == c(FALSE, TRUE)))
  expect_true(all(lang_en_eu == c(TRUE, FALSE)))
  expect_true(all(lang_fr_eu == c(FALSE, TRUE)))
})


ut_pause(1)
res9 <- spp_cites_legislation(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
ut_pause()
res10 <- spp_eu_legislation(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
ut_pause()
res11 <- spp_cites_legislation(taxon_id = c(tx_id, tx_id2), raw = TRUE,
  verbose = FALSE)
ut_pause()
res12 <- spp_eu_legislation(taxon_id = c(tx_id, tx_id2), raw = TRUE,
  verbose = FALSE)


test_that("leg_multi outputs", {
  expect_equal(class(res9), "spp_cites_leg_multi")
  expect_equal(class(res10), "spp_eu_leg_multi")
  expect_equal(class(res9$cites_listings), cl_df)
  expect_equal(class(res10$eu_listings), cl_df)
  #
  expect_equal(nrow(res9$cites_listings),
    nrow(res1$cites_listings) + nrow(res1b$cites_listings))
  expect_equal(nrow(res10$eu_listings),
    nrow(res5$eu_listings) + nrow(res5b$eu_listings))
  #
  expect_identical(unique(res9$cites_listings$taxon_id),  c(tx_id, tx_id2))
  expect_identical(unique(res10$eu_listings$taxon_id),  c(tx_id, tx_id2))
  #
  expect_identical(class(res11), cl_raw_multi)
  expect_identical(class(res12), cl_raw_multi)
  #
  expect_equal(class(res11[[1L]]), cl_raw)
  expect_equal(class(res12[[1L]]), cl_raw)
  #
  expect_equal(length(res11), 3)
  expect_equal(length(res12), 3)
  #
  expect_identical(res11$taxon_id, c(tx_id, tx_id2))
  expect_identical(res12$taxon_id, c(tx_id, tx_id2))
})
ut_pause()

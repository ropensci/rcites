context("Legislations")

skip_on_cran()
skip_if_no_auth()
#
res1 <- spp_cites_legislation(taxon_id = tx_id)
res2 <- spp_cites_legislation(taxon_id = tx_id, raw = TRUE)
ut_pause()
res3 <- spp_cites_legislation(taxon_id = tx_id, scope = 'all')
res4 <- spp_cites_legislation(taxon_id = tx_id, language = 'fr')
ut_pause()
#
res5 <- spp_eu_legislation(taxon_id = tx_id)
res6 <- spp_eu_legislation(taxon_id = tx_id, raw = TRUE)
ut_pause()
res7 <- spp_eu_legislation(taxon_id = tx_id, scope = 'all')
res8 <- spp_eu_legislation(taxon_id = tx_id, language = 'fr')
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

test_that("Expected behaviour", {
 expect_true(all(res1$cites_listings$is_current))
 expect_true(!all(res3$cites_listings$is_current))
 expect_true(all(res5$eu_listings$is_current))
 expect_true(!all(res7$eu_listings$is_current))
})


lang_en_ci <- c("Guinea", "Guinée") %in% res1$cites_suspensions$geo_entity.name
lang_fr_ci <- c("Guinea", "Guinée") %in% res4$cites_suspensions$geo_entity.name

lang_en_eu <- c("Ethiopia", "Ethiopie") %in% res5$eu_decisions$geo_entity.name
lang_fr_eu <- c("Ethiopia", "Ethiopie") %in% res8$eu_decisions$geo_entity.name

test_that("Language", {
  expect_true(all(lang_en_ci == c(TRUE, FALSE)))
  expect_true(all(lang_fr_ci == c(FALSE, TRUE)))
  expect_true(all(lang_en_eu == c(TRUE, FALSE)))
  expect_true(all(lang_fr_eu == c(FALSE, TRUE)))
})

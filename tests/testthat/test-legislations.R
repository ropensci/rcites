context("legislation eu")

skip_on_cran()
skip_if_no_auth()

ut_pause()
res1 <- taxon_eu_legislation(tax_id = tx_id)
ut_pause()
res2 <- taxon_eu_legislation(tax_id = tx_id, type ='listings')
ut_pause()
res3 <- taxon_eu_legislation(tax_id = tx_id, simplify = TRUE)
#
nm1 <- c("id", "taxon_concept_id", "is_current", "annex", "change_type", "effective_at", "annotation")
nm2 <- c("id", "taxon_concept_id", "notes", "start_date", "is_current", "eu_decision_type", "geo_entity", "start_event", "source", "term")

test_that("expected output classes", {
  expect_equal(class(res1), "list")
  expect_equal(class(res2), "list")
  expect_equal(class(res3), "list")
  expect_true(all(class(res2$eu_listings) == cl_dt))
  expect_equal(class(res2$eu_listings$id), "list")
  expect_equal(class(res3$eu_listings$id), "integer")
  expect_equal(class(res3$eu_decisions$start_event_date), "Date")
})

test_that("expected output names", {
  expect_true(all(names(res1) == c("eu_listings", "eu_decisions")))
  expect_true(names(res2) == "eu_listings")
  expect_true(all(names(res2$eu_listings) == names(res1$eu_listings)))
  expect_true(all(names(res1$eu_listings) == nm1))
  expect_true(all(names(res1$eu_decisions) == nm2))
  expect_true(sum(grepl(names(res3$eu_decisions), pattern = "geo_entity_")) == 3)
})

test_that("expected values", {
  expect_equal(res3$eu_listings$taxon_concept_id[1L], tx_id)
  expect_equal(res3$eu_decisions$taxon_concept_id[1L], tx_id)
})






context("legislation cites")

ut_pause()
res4 <- taxon_cites_legislation(tax_id = tx_id)
ut_pause()
res5 <- taxon_cites_legislation(tax_id = tx_id, type ='listings')
ut_pause()
res6 <- taxon_cites_legislation(tax_id = tx_id, simplify = TRUE)

test_that("expected output classes", {
  expect_equal(class(res4), "list")
  expect_equal(class(res5), "list")
  expect_equal(class(res6), "list")
  expect_true(all(class(res4$cites_listings) == cl_dt))
  expect_equal(class(res5$cites_listings$id), "integer")
})

test_that("expected output names", {
  expect_true(all(names(res4) == c("cites_listings", "cites_quotas", "cites_suspensions")))
  expect_true(names(res5) == "cites_listings")
  expect_true(all(names(res4$cites_listings) == names(res5$cites_listings)))
  expect_true(sum(grepl(names(res6$cites_suspensions), pattern = "geo_entity_")) == 3)
  expect_true(sum(grepl(names(res6$cites_suspensions), pattern = "start_notification_")) == 3)
})

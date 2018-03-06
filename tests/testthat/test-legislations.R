context("legislation eu")

tx_id <- 4521
res1 <- taxon_eu_legislation(tax_id = tx_id)
res2 <- taxon_eu_legislation(tax_id = tx_id, type ='listings')
res3 <- taxon_eu_legislation(tax_id = tx_id, simplify = TRUE)

test_that("expected output classes", {
  expect_equal(class(res1), "list")
  expect_equal(class(res2), "list")
  expect_equal(class(res3), "list")
  expect_true(all(class(res2$eu_listings) == c("data.table", "data.frame")))
  expect_equal(class(res2$eu_listings$id), "list")
  expect_equal(class(res3$eu_listings$id), "integer")
})


test_that("expected output names", {
  expect_true(all(names(res1) == c("eu_listings", "eu_decisions")))
  expect_true(names(res2) == "eu_listings")
  expect_true(all(names(res2$eu_listings) == names(res1$eu_listings)))
  expect_true(all(names(res1$eu_listings) == c("id", "taxon_concept_id", "is_current", "annex", "change_type", "effective_at", "annotation")))
  expect_true(all(names(res1$eu_decisions) == c("id", "taxon_concept_id", "notes", "start_date", "is_current", "eu_decision_type", "geo_entity", "start_event", "source", "term")))
})

test_that("expected values", {
  expect_equal(res3$eu_listings$taxon_concept_id[1L], tx_id)
  expect_equal(res3$eu_decisions$taxon_concept_id[1L], tx_id)
})

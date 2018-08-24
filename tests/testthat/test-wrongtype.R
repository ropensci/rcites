context("wrong type")

token <- "wrong"

test_that("expected output classes", {
  expect_error(spp_cites_legislation(tx_id, token = token, type = "wrongAgain"), "all(type %in% c(\"listings\", \"quotas\", \"suspensions\")) is not TRUE", fixed = TRUE)
  expect_error(spp_eu_legislation(tx_id, token = token, type = "wrongAgain"), "all(type %in% c(\"listings\", \"decisions\")) is not TRUE", fixed = TRUE)
  expect_error(spp_references(tx_id, token = token, type = "wrongAgain"), "all(type %in% c(\"taxonomic\", \"distribution\")) is not TRUE", fixed = TRUE)
})

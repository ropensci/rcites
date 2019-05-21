context("Taxon concept")

skip_on_cran()
skip_if_no_auth()


res1 <- spp_taxonconcept(query_taxon = tx_nm)
nm1 <- c("all_id", "general", "higher_taxa", "accepted_names", "common_names",
"synonyms", "cites_listings")
nm2 <- c("id", "full_name", "author_year", "rank", "name_status", "updated_at",
  "active", "cites_listing")
ut_pause()

res2 <- spp_taxonconcept(query_taxon = tx_nm, raw = TRUE)
ut_pause()

res3 <- spp_taxonconcept(query_taxon = '', taxonomy = 'CMS', pages = 1:2,
  language = 'EN', verbose = FALSE)
ut_pause()

res3b <- spp_taxonconcept(query_taxon = '', pages = c(1, 83),
  language = 'EN', verbose = FALSE)
ut_pause()

res4 <- spp_taxonconcept(query_taxon = '', pages = c(44), per_page = 20,
  with_descendants = FALSE, verbose = FALSE)
ut_pause()

res5 <- spp_taxonconcept(query_taxon = '', pages = 1,
  updated_since = "2016-01-01", verbose = FALSE)
ut_pause()


test_that("Expected classes", {
  expect_equal(class(res1), "spp_taxon")
  expect_equal(length(res1), 7)
  expect_true(all(names(res1) == nm1))
  expect_true(class(res1[1L]) == "list")
  expect_true(all(names(res1[[2L]]) == nm2))
  expect_true(all(unlist(lapply(res1, function(x) all(class(x) == cl_df)))))
  expect_true(all(class(res2) == cl_raw))
  expect_equal(class(res3$higher_taxa$kingdom), "character")
  expect_equal(class(res1$cites_listings$annotation), "character")
  expect_equal(attributes(res1)$taxonomy, "CITES")
  expect_equal(attributes(res3)$taxonomy, "CMS")
  expect_equal(attributes(res3b)$taxonomy, "CITES")
})


test_that("Expected behaviour", {
  expect_equal(nrow(res3[[1L]]), 1000)
  expect_equal(nrow(res3b[[1L]]), 1000)
  expect_true(all(res3$common_names$language == "EN"))
  expect_equal(nrow(res4[[1L]]), 20)
  expect_true(all(res5$general$updated_at > "2016-01-01"))
  ut_pause()
  expect_warning(spp_taxonconcept(query_taxon = "Homo sapiens"),
    "Taxon not listed.", fixed = TRUE)
  expect_error(spp_taxonconcept(query_taxon = tx_nm, taxonomy = "WRONG"))
})

nm1 <- c(
  "all_id", "general", "higher_taxa", "accepted_names", "common_names",
  "synonyms", "cites_listings"
)
nm2 <- c(
  "id", "full_name", "author_year", "rank", "name_status", "updated_at",
  "active", "cites_listing"
)

test_that("spp_taxonconcept() defaults work", {
  vcr::use_cassette("spp_taxonconcept_def", {
    suppressMessages(res <- spp_taxonconcept(query_taxon = tx_nm))
  })
  expect_s3_class(res, "spp_taxon")
  expect_equal(length(res), 7)
  expect_true(all(names(res) == nm1))
  expect_type(res[1L], "list")
  expect_true(all(names(res[[2L]]) == nm2))
  expect_true(all(unlist(lapply(res, function(x) is_cl_df(x)))))
  expect_type(res$cites_listings$annotation, "character")
  expect_equal(attributes(res)$taxonomy, "CITES")
  expect_snapshot(print(res))
})


suppressMessages({
  test_that("spp_taxonconcept() raw mode works", {
    vcr::use_cassette("spp_taxonconcept_raw", {
      expect_silent(res1 <- spp_taxonconcept(
        query_taxon = tx_nm, raw = TRUE,
        verbose = FALSE
      ))
      expect_warning(
        res2 <- spp_taxonconcept(query_taxon = 0, raw = TRUE, verbose = FALSE), "Taxon not listed."
      )
    })
    expect_true(is_cl_rw(res1))
    expect_true(is.null(res2))
  })

  test_that("spp_taxonconcept() CMS works", {
    vcr::use_cassette("spp_taxonconcept_cms", {
      res <- spp_taxonconcept(query_taxon = "", taxonomy = "CMS", per_page = 10, pages = 1:2, language = "EN", verbose = FALSE)
    })
    expect_s3_class(res, "spp_taxon")
    expect_equal(nrow(res[[1L]]), 20)
    expect_equal(attributes(res)$taxonomy, "CMS")
    expect_true(all(res$common_names$language == "EN"))
    expect_type(res$higher_taxa$kingdom, "character")
  })

  test_that("spp_taxonconcept() page selection works", {
    vcr::use_cassette("spp_taxonconcept_pag", {
      res <- spp_taxonconcept(
        query_taxon = "", pages = c(43:44), per_page = 10,
        with_descendants = FALSE, verbose = FALSE
      )
    })
    expect_equal(nrow(res[[1L]]), 20)
  })
})


test_that("spp_taxonconcept() updated_since works", {
  vcr::use_cassette("spp_taxonconcept_upd", {
    res <- spp_taxonconcept(
      query_taxon = "",
      updated_since = "2018-01-01", verbose = FALSE, page = 1
    )
  })
  expect_true(all(res$general$updated_at >= "2018-01-01"))
})
# maybe a problem with data in URL

nm1 <- c("id", "citation", "is_standard")

test_that("spp_references() defaults works", {
  vcr::use_cassette("spp_references_def", {
    suppressMessages(res <- spp_references(taxon_id = tx_id))
  })
  expect_s3_class(res, "spp_refs")
  expect_true(is(res[1L], "list"))
  expect_true(all(unlist(lapply(res, function(x) is_cl_df(x)))))
  expect_true(all(names(res$references == nm1)))
  expect_snapshot(print(res))
})

test_that("spp_references() raw mode", {
  vcr::use_cassette("spp_references_raw", {
    expect_silent(res1 <- spp_references(
      taxon_id = tx_id,
      raw = TRUE,
      verbose = FALSE
    ))
    expect_warning(res2 <- spp_references(
      taxon_id = 0, raw = TRUE,
      verbose = FALSE
    ))
  })
  expect_true(is_cl_rw(res1))
  expect_true(is_cl_rw(res2))
  expect_equal(
    res2$error$message,
    "We are sorry but an error occurred processing your request"
  )
})

test_that("spp_references() batch mode works", {
  vcr::use_cassette("spp_references_bat", {
    res <- spp_references(taxon_id = c(tx_id, tx_id2), verbose = FALSE)
  })
  expect_s3_class(res, "spp_refs_multi")
  expect_true(is_cl_df(res$references))
  expect_identical(unique(res$references$taxon_id), c(tx_id, tx_id2))
})

test_that("spp_references() raw batch mode works", {
  vcr::use_cassette("spp_references_ram", {
    res <- spp_references(
      taxon_id = c(tx_id, tx_id2), raw = TRUE,
      verbose = FALSE
    )
  })
  expect_true(is_cl_rm(res))
  expect_true(is_cl_rw(res[[1L]]))
  expect_equal(length(res), 3)
  expect_identical(res$taxon_id, c(tx_id, tx_id2))
})

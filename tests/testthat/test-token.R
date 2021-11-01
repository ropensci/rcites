token <- "wrong"
msg <- "Unauthorized (HTTP 401)"
q_url <- rcites_url(paste0("taxon_concepts/", tx_id, "/distributions.json"))


test_that("test token", {
  old <- Sys.getenv("SPECIESPLUS_TOKEN")
  suppressMessages(on.exit(set_token(old)))
  expect_snapshot(set_token("hackme"))
  expect_identical(rcites_getsecret(), "hackme")
})

test_that("caught wrong token", {
  vcr::use_cassette("wrong_token", {
    expect_warning(res <- rcites_res(q_url, token, FALSE, TRUE), 
      class = "http_401")
  })  
})


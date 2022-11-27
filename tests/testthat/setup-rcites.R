library("vcr") # *Required* as vcr is set up on loading

# see https://books.ropensci.org/http-testing/vcr.html

vcr_dir <- vcr::vcr_test_path("fixtures")

if (!nzchar(Sys.getenv("SPECIESPLUS_TOKEN"))) {
  if (dir.exists(vcr_dir)) {
    # Fake API token to fool our package
    Sys.setenv("SPECIESPLUS_TOKEN" = "hackme")
  } else {
    # If there's no mock files nor API token, impossible to run tests
    stop("No API key nor cassettes, tests cannot be run.",
      call. = FALSE
    )
  }
}


invisible(vcr::vcr_configure(
  dir = vcr_dir,
  filter_request_headers = list("X-Authentication-Token" = "safe"),
  serialize_with = "json"
))

vcr::check_cassette_names()

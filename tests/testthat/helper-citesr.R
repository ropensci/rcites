# https://cran.r-project.org/web/packages/httr/vignettes/secrets.html
skip_if_no_auth <- function() {
    if (identical(Sys.getenv("SPECIESPLUS_TOKEN"), "")) {
        skip("No authentication available")
    }
}

tx_nm <- "Loxodonta africana"
tx_id <- 4521

ut_pause <- function() Sys.sleep(4)

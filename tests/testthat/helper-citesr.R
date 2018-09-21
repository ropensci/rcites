# https://cran.r-project.org/web/packages/httr/vignettes/secrets.html
skip_if_no_auth <- function() {
    if (identical(Sys.getenv("SPECIESPLUS_TOKEN"), "")) {
        skip("No authentication available")
    }
}

tx_nm <- "Loxodonta africana"
tx_id <- 4521
tx_id2 <- "3210"
cl_df <- c("tbl_df", "tbl",  "data.frame")
cl_raw <- c("list", "spp_raw")

ut_pause <- function(x = 4) Sys.sleep(x)

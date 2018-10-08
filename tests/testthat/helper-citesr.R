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
cl_raw_multi <- c("list", "spp_raw_multi")

ut_pause <- function(x = 5) Sys.sleep(x)

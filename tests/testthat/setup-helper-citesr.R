library(tibble)

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

is_cl <-  function(x, cls) {
  all(unlist(lapply(cls, function(y) is(x, y))))
}

is_cl_df <- function(x) {
  is_cl(x, c("tbl_df", "tbl",  "data.frame")) 
}

is_cl_rw <- function(x) {
  is_cl(x, c("list", "spp_raw")) 
}

is_cl_rm <- function(x) {
  is_cl(x, c("list", "spp_raw_multi")) 
}

# https://cran.r-project.org/web/packages/httr/vignettes/secrets.html
skip_if_no_auth <- function() {
    if (identical(Sys.getenv("SPPPLUS_TOKEN"), "")) {
        skip("No authentication available")
    }
}

sw <- function(x) suppressWarnings(x)

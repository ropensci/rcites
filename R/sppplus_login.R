#' Login helper function
#'
#' This function sets the authentification token for the current session.
#'
#' @param token a character string containing you token. If `NULL` then the
#' token can be passed interactively.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation}
#'
#' @export
#'
#' @examples
#' \donttest{
#'  sppplus_login()
#' }

sppplus_login <- function(token = NULL) {
    if (is.null(token)) 
        token <- readline("Enter your token: ")
    if (identical(token, "")) {
        message("no token provided")
    } else {
        Sys.setenv(SPPPLUS_TOKEN = token)
        cat("Authentication token stored for the session.\n")
    }
    invisible(NULL)
}

#' Login helper function
#'
#' This function sets the authentification token for the current session.
#'
#' @param token a character string (with quotes) containing you token. If `NULL` then the
#' token can be passed without quotes (not as character string) after a prompt.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation}
#'
#' @export
#'
#' @examples
#' \donttest{
#'  set_token()
#' }

set_token <- function(token = NULL) {
    if (is.null(token)) 
        token <- readline("Enter your token: ")
    if (identical(token, "")) {
        message("no token provided")
    } else {
        Sys.setenv(SPECIESPLUS_TOKEN = token)
        cat("Authentication token stored for the session.\n")
    }
    invisible(NULL)
}

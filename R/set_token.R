#' Login helper function
#'
#' Set and forget the authentification token for the current session.
#'
#' @param token a character string (with quotes) containing your token. If `NULL`
#' then the token can be passed without quotes (not as character string) after
#' a prompt.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation}
#'
#' @export
#'
#' @examples
#' \donttest{
#'  # NB the token below is not working
#'  set_token('8QW6Qgh57sBG2k0gtt')
#'  # interactively
#'  set_token()
#' }

#' @describeIn set_token set the environment variable `SPECIESPLUS_TOKEN`.
set_token <- function(token = NULL) {
    if (is.null(token)) 
        token <- readline("Enter your token without quotes: ")
    if (identical(token, "")) {
        message("no token provided")
    } else {
        Sys.setenv(SPECIESPLUS_TOKEN = token)
        cat("Authentication token stored for the session.\n")
    }
    invisible(NULL)
}

#' @describeIn set_token forget the environment variable `SPECIESPLUS_TOKEN`.
#' @export
forget_token <- function() Sys.unsetenv("SPECIESPLUS_TOKEN")

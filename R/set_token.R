#' Login helper function
#'
#' Set and forget the authentification token for the current session.
#'
#' @param token a character string (with quotes) containing your token. If
#' `NULL`, then the token can be passed without quotes (not as a character
#' string) after a prompt.
#'
#' @references
#' <https://api.speciesplus.net/documentation>
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # NB: the token below is not working and should not be used
#' set_token("8QW6Qgh57sBG2k0gtt")
#' }

#' @describeIn set_token set the environment variable `SPECIESPLUS_TOKEN`.
set_token <- function(token = NULL) {
    nat <- 5
    for (k in seq_len(5)) {
        if (is.null(token) || identical(token, "")) {
            cli::cli_alert_warning("No token has been provided yet.")
            token <- readline("Enter your token without quotes: ")
        } else {
            if (k < nat) break
        }
        if (k == nat) stop("Token still not set after ", nat," attempts.")
    }
    if (!grepl("[[:alnum:]]+", token)) {
        cli::cli_alert_warning("The token may not have the right format.")
    }
    Sys.setenv(SPECIESPLUS_TOKEN = token)
    cli::cli_alert_success("Token stored for the session.")
    invisible(NULL)
}

#' @describeIn set_token forget the environment variable `SPECIESPLUS_TOKEN`.
#' @export
forget_token <- function() {
    Sys.unsetenv("SPECIESPLUS_TOKEN")
    cli::cli_alert_success("Token has been unset.")
}
#' Simplify outputs
#'
#' Simplify the structure of cites/species+ API outputs.
#'
#' @param x a data.table to be simplified.
#'
#' @return A data table with a simplified structure.
#'
#' @details For the sake of generality, API outputs are parsed and stored in
#' data.table objects whose columns are lists. Most of the lists are actually
#' well-structured and can actually be stored as columns of integer, date,
#' characters strings, etc. This function handles such simplifications.
#'
#' @export

sppplus_simplify <- function(x) {
    cla_col <- sapply(x, function(y) class(y[[1L]]))
    for (i in 1:ncol(x)) {
        if (cla_col[i] %in% c("character", "integer", "logical", "numeric")) 
            data.table::set(x, j = i, value = methods::as(x[[i]], cla_col[i]))
    }
    invisible(NULL)
}


# 'geo_entity'
sppplus_geo_entity <- function(x) {
    out <- do.call(rbind.data.frame, lapply(x, function(y) do.call(cbind.data.frame, 
        y)))
    names(out) <- paste0("geo_entity_", names(out))
    out
}

# 'start_notification' / 'start_event'
sppplus_start_event <- function(x) {
    out <- do.call(rbind.data.frame, lapply(x, function(y) do.call(cbind.data.frame, 
        y)))
    out$date <- as.Date(out$date)
    names(out) <- paste0("start_event_", names(out))
    out
}

# 'decision_type'
sppplus_decision_type <- function(x) {
    out <- do.call(rbind.data.frame, lapply(x, function(y) do.call(cbind.data.frame, 
        y)))
    out$date <- as.Date(out$date)
    names(out) <- paste0("start_event_", names(out))
    out
}

# sppplus_start_event(res3$eu_decisions$start_event) df3[,foo:=NULL]

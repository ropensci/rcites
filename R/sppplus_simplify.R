#' Simplify outputs
#'
#' Simplify the structure of cites/species+ API outputs.
#'
#' @param x a data.table to be simplified.
#'
#' @return A data table with a simplified structure.
#'
#' @details For the sake of generality, CITES Species+ API outputs are parsed
#' and stored in data.table objects whose columns are lists. Most of the lists
#' are actually well-structured and can actually be stored as columns of integer,
#' date, characters strings, etc. This function handles such simplifications.
#'
#' @importFrom data.table :=
#' @export

sppplus_simplify <- function(x) {
    cla_col <- sapply(x, function(y) class(y[[1L]]))
    for (i in 1:ncol(x)) {
        if (cla_col[i] %in% c("character", "integer", "logical", "numeric")) 
            data.table::set(x, j = i, value = methods::as(x[[i]], cla_col[i]))
    }
    # 
    spc <- c("geo_entity", "start_notification", "start_event", "decision_type")
    tst <- names(x) %in% spc
    if (sum(tst)) {
        nid <- names(x)[tst]
        for (i in nid) {
            tmp <- sppplus_special_case(x[[i]], i)
            x[, `:=`(names(tmp), tmp)]
        }
        x[, `:=`((nid), NULL)]
    }
    # uses only references so output is invisible
    invisible(NULL)
}


# res1 <- taxon_cites_legislation(tax_id = '4521')
# sppplus_simplify(res1$cites_suspensions) names(res1$cites_suspensions)



# replace
sppplus_special_case <- function(x, case) {
    out <- do.call(rbind.data.frame, lapply(x, function(y) do.call(cbind.data.frame, 
        y)))
    if ("date" %in% names(out)) 
        out$date <- as.Date(out$date)
    names(out) <- paste0(case, "_", names(out))
    out
}

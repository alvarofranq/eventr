#' @title Get handlers
#'
#' @description This function returns the list of handlers on a dispatcher type object
#'
#' @param obj a `R` object.
#'
#' @rdname get_handlers
#' @export
get_handlers <- function(obj) UseMethod("get_handlers")

#' @rdname get_handlers
#' @export
get_handlers.dispatcher <- function(obj) obj[['handlers']]

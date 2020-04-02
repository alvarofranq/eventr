#' @title Get dispatch function
#'
#' @description This function returns the dispatch function of a dispatcher type object
#'
#' @param obj An object of class dispatcher
#'
#' @export
get_dispatch <- function(obj) UseMethod("get_dispatch")

#' @export
get_dispatch.dispatcher <- function(obj) obj[['dispatch']]

#' @title Get Event Header
#'
#' @description This function returns the header of an event or list of events.
#'
#' @param obj An event or a list of events
#'
#' @examples
#'
#' first_event <- event(id = 'first-event', type = 'FIRST_EVENT', time = Sys.time())
#'
#' get_header(first_event)
#'
#' @importFrom purrr map
#'
#' @export
get_header <- function(obj) UseMethod("get_header")

#' @export
get_header.event <- function(obj) obj[["header"]]

#' @export
get_header.event_list <- function(obj){
  headers <- purrr::map(obj, get_header)
  return(headers)
}

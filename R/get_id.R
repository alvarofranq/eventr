#' @title Get Event Identifier
#'
#' @description This function returns the identifier of an event or list of events.
#'
#' @param obj An event or a list of events.
#'
#' @examples
#'
#' first_event <- event(id = 'first-event', type = 'FIRST_EVENT', time = Sys.time())
#'
#' get_id(first_event)
#'
#' @importFrom purrr map
#'
#' @export
get_id <- function(obj) UseMethod("get_id")

#' @export
get_id.event <- function(obj) get_header(obj)[["id"]]

#' @export
get_id.event_list <- function(obj){
  ids <- purrr::map(event, get_id)
  return(ids)
}


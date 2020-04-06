#' @title Get Event Body
#'
#' @description This function returns the body of an event or list of events.
#'
#' @param obj An event or a list of events.
#'
#' @examples
#'
#' first_event <- event(
#'   id = 'first-event',
#'   type = 'FIRST_EVENT',
#'   time = Sys.time(),
#'   attr_01 = 'first-body-attr',
#'   attr_02 = 'second-body-attr'
#' )
#'
#' get_body(first_event)
#'
#' @importFrom purrr map
#' @export
get_body <- function(obj) UseMethod("get_body")

#' @export
get_body.event <- function(obj) obj[["body"]]

#' @export
get_body.event_list <- function(obj){
  bodys <- purrr::map(obj, get_body)
  return(bodys)
}

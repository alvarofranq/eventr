#' @title Get Event Body Attribute
#'
#' @description This function returns an attribute or list of attributes from the body of an event or list of events.
#'
#' @param obj An event or a list of events.
#' @param attr A character string indicating the attribute to return.
#'
#' @return \code{get_body_attr()} returns a single attribute from an \code{event} or an \code{event_list} object.
#'
#' @examples
#'
#' first_event <- event(
#'   id = 'first-event',
#'   type = 'FIRST_EVENT',
#'   time = Sys.time(),
#'   attr_01 = 'first-attribute-01'
#' )
#'
#' second_event <- event(
#'   id = 'second-event',
#'   type = 'SECOND_EVENT',
#'   time = Sys.time(),
#'   attr_01 = 'first-attribute-02'
#' )
#'
#' the_event_list <- event_list(first_event, second_event)
#'
#' get_type(the_event_list)
#'
#' @importFrom purrr map
#'
#' @export
get_body_attr <- function(obj, attr) UseMethod("get_body_attr")

#' @export
get_body_attr.event <- function(obj, attr) get_body(obj)[[attr]]

#' @export
get_body_attr.event_list <- function(obj, attr){
  attrs <- purrr::map(obj, function(e) get_body_attr(e, attr))
  return(attrs)
}

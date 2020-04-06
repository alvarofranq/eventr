#' @title Get Event Type
#'
#' @description This function returns the type of an event or list of events.
#'
#' @param obj An event or a list of events.
#'
#' @examples
#'
#' first_event <- event(id = 'first-event', type = 'FIRST_EVENT', time = Sys.time())
#' second_event <- event(id = 'second-event', type = 'SECOND_EVENT', time = Sys.time())
#'
#' the_event_list <- event_list(first_event, second_event)
#'
#' get_type(the_event_list)
#'
#' @importFrom purrr map
#'
#' @export
get_type <- function(obj) UseMethod("get_type")

#' @export
get_type.event <- function(obj) get_header(obj)[["type"]]

#' @export
get_type.event_list <- function(obj){
  types <- purrr::map_chr(obj, get_type)
  return(types)
}

#' @export
get_type.list <- function(obj) purrr::map_chr(obj, get_type)

#' @export
get_type.handlers_list <- function(obj) get_type.list(obj)

#' @export
get_type.handler <- function(obj) obj[['type']]

#' @export
get_type.dispatcher <- function(obj) {

  handlers <- get_handlers(obj)
  types <- get_type(handlers)
  return(types)

}

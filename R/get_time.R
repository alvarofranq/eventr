#' @title Get Event Time
#'
#' @description This function returns the time of an event or list of events.
#'
#' @param obj An event or a list of events
#'
#' @examples
#'
#' first_event <- event(
#'   id = 'first-event',
#'   type = 'FIRST_EVENT',
#'   time = Sys.time()
#' )
#'
#' get_time(first_event)
#'
#' @importFrom purrr map
#'
#' @export
get_time <- function(obj) UseMethod("get_time")

#' @export
get_time.event <- function(obj) get_header(obj)[["time"]]

#' @export
get_time.event_list <- function(obj){
  times <- purrr::map(obj, get_time)
  return(times)
}

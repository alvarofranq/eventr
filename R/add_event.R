#' @title Add Event
#'
#' @description this functions allows you to add events or event_list object to an other event or event_list objects.
#'
#' @param e1 An object of class event or event_list.
#' @param e2 An object of class event.
#'
#' @examples
#'
#' library(eventr)
#' library(dplyr)
#' library(purrr)
#'
#' birth_event <- event(
#'   id = 'first-id',
#'   type = 'BIRTH',
#'   time = '1936-11-09',
#'   birth_date = '1936-11-09'
#' )
#'
#' measurement_event <- event(
#'   id = 'second-id',
#'   type = 'MEASUREMENT',
#'   time = '1937-11-09',
#'   weight = list(value = 10.2, unit = "kg"),
#'   height = list(value = 0.76, unit = "m")
#' )
#'
#' death_event <- event(
#'   id = 'third-id',
#'   type = 'DEATH',
#'   time = '2019-05-22',
#'   death_date = '2019-05-22')
#'
#' the_event_list <- birth_event %>%
#'   add_event(measurement_event) %>%
#'   add_event(death_event)
#'
#' the_event_list <- birth_event +
#'   measurement_event +
#'   death_event
#'
#' the_event_list
#'
#' # transform the_event_list to data.frame
#'
#' the_event_list %>%
#'   purrr::map(as.data.frame) %>%
#'   bind_rows()
#'
#'
#' @export
add_event <- function(e1, e2) UseMethod("add_event")

#' @export
add_event.list <- function(e1, e2){

  li <- c(e1, list(e2))
  li <- do.call("event_list", args = li)
  return(li)

}

#' @export
add_event.event <- function(e1, e2){

  eventlist <- event_list(e1, e2)
  return(eventlist)

}

#' @export
add_event.event_list <- function(e1, e2){

  eventlist <- add_event.list(e1, e2)
  return(eventlist)

}

#' @title Add events to an event list
#'
#' @description + allows the user to add events or event_list object to an
#' other event or event_list objects.
#'
#' @param e1 An object of class event or event_list.
#' @param e2 An object of class event.
#'
#' @examples
#'
#' library(eventr)
#' library(magrittr)
#'
#' birth_event <- event(
#'   id = 'first-id',
#'   type = 'BIRTH',
#'   time = '1936-11-09',
#'   birth_date = '1936-11-09'
#' )
#'
#' measurement_event <- event(
#'   id = 'second-id',
#'   type = 'MEASUREMENT',
#'   time = '1937-11-09',
#'   weight = list(value = 10,2, unit = "kg"),
#'   height = list(value = 0,76, unit = "m")
#' )
#'
#' death_event <- event(
#'   id = 'third-id',
#'   type = 'DEATH',
#'   time = '2019-05-22',
#'   death_date = '2019-05-22')
#'
#' the_event_list <-
#'   birth_event +
#'   measurement_event +
#'   death_event
#'
#' @rdname event-add
#' @export
`+.event` <- function(e1, e2) {

  add_event(e1, e2)

}

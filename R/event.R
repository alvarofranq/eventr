#' @title Event Constructor
#'
#' @description Event constructor
#' @param id A character identifier
#' @param type A character indicating the event type
#' @param time A character string indicating the event timestamp
#' @param ... A list with the event attributes.
#'
#' @return The function returns an object of class \code{event}. \code{event}
#' objects are implemented as a list of two main elements: A \code{head} and
#' a \code{body}.The \code{head} contains an identifier (\code{id}), a string
#' indicating the event type (\code{type}) and a \code{POSIXct} object indicating
#' when the event occurs (\code{time}). The \code{body} containts the event attributes
#' defined by the user. By default \code{id} is generated using \pkg{uuid} and \code{time}
#' value is the result of \code{Sys.time()} function by default.
#'
#' @examples
#'
#' birth_event <- event(
#'   id = 'first-id',
#'   type = 'BIRTH',
#'   time = '1936-11-09',
#'   birth_date = '1936-11-09'
#' )
#'
#' death_event <- event(
#'   id = 'second-id',
#'   type = 'DEATH',
#'   time = '2019-05-22',
#'   death_date = '2019-05-22'
#' )
#'
#' @rdname event
#' @export
new_event <- function(id = uuid::UUIDgenerate(), type, time = Sys.time(), ...){

  structure(
    .Data = list(
      header = list(
        id = id,
        type = type,
        time = time
      ),
      body = list(...)
    ),
    class = c("event", "list")
  )

}

#' @rdname event
#' @export
validate_event <- function(id, type, time, ... ){

  valid <- c(

    is.character(id),
    is.character(type),
    inherits(Sys.time(), "POSIXct")

  )

  return(all(valid))

}

#' @rdname event
#' @export
event <- function(id = uuid::UUIDgenerate(), type, time, ...){

  stopifnot(validate_event(id, type, time, ...))
  .event <- new_event(id, type, time, ...)
  return(.event)

}

#' @title Event Constructor
#'
#' @description Event constructor
#' @param id A character identifier
#' @param type A character indicating the event type
#' @param time A character string indicating the event timestamp
#' @param ... A list with the event attributes.
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
new_event <- function(id, type, time, ...){

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
event <- function(id, type, time, ...){

  stopifnot(validate_event(id, type, time, ...))
  .event <- new_event(id, type, time, ...)
  return(.event)

}

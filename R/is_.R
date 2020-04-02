#' @title Is an Object from a class?
#'
#' @description Test if an object is some of the classes implemented in `eventr` package.
#'
#' @param x a `R` object
#'
#' @example
#'
#' birth_event <- event(
#'   id = 'first-id',
#'   type = 'BIRTH',
#'   time = '1936-11-09',
#'   birth_date = '1936-11-09'
#' )
#'
#' is_event(birth_event)
#'
#' @export
is_event <- function(x) inherits(x, 'event')

#' @rdname is_event
#' @export
is_event_list <- function(x) inherits(x, 'event_list')

#' @rdname is_event
#' @export
is_handlers_list <- function(x) inherits(x, 'handlers_list')

#' @rdname is_event
#' @export
is_handler <- function(x) inherits(x, 'handler')

#' @rdname is_event
#' @export
is_dispatcher <- function(x) inherits(x, 'dispatcher')

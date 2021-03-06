#' @title Event list
#' @description Event list constructor. The function validates the structure of
#' the input params and creates an event_list object.
#'
#' @param ... A set of `event` type objects.
#'
#' @return  The \code{event_list()} function returns a list of \code{event} objects.
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
#' the_event_list <- event_list(birth_event, death_event)
#'
#' @importFrom purrr map_chr
#'
#' @rdname event_list
#' @export
new_event_list <- function(...) {

  li <- list(...)
  times <- purrr::map(li, get_time)
  times <- unlist(times)
  the_order <- order(times)
  li <- li[the_order]
  .event_list <- structure(.Data = li, class = c('event_list', 'list'))
  return(.event_list)

}

#' @rdname event_list
#' @export
validate_event_list <- function(...) {

  li <- list(...)
  check_if_event <- sapply(li, is_event)

}

#' @rdname event_list
#' @export
event_list <- function(...) {

  stopifnot(validate_event_list(...))
  .event_list <- new_event_list(...)
  return(.event_list)

}

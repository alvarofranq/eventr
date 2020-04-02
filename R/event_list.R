#' @title Event list
#' @description Event list constructor
#'
#' @param ... A set of Event type objects.
#'
#' @examples
#' birthEvent <- event('first-id', type = 'BIRTH', time = '1936-11-09', birthDate = '1936-11-09')
#' deathEvent <- event('second-id', type = 'DEATH', time = '2019-05-22', deathDate = '2019-05-22')
#'
#' eventList <- event_list(birthEvent, deathEvent)
#'
#' @importFrom purrr map_chr
#'
#' @rdname event_list
#' @export
new_event_list <- function(...) {

  li <- list(...)
  times <- purrr::map_chr(li, get_time)
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

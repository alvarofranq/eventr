#' @title Dispatcher
#'
#' @description Dispatcher Constructor.
#'
#' @param handlers A list of handlers build using handler() function.
#'
#' @examples
#'
#' library(eventr)
#' library(dplyr)
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
#' set_birth_date <- function(obj, event){
#'   obj$birth_date <- get_body_attr(event, "birth_date")
#'   return(obj)
#' }
#'
#' set_death_date <- function(obj, event){
#'   obj$death_date <- get_body_attr(event, "death_date")
#'   return(obj)
#' }
#'
#' birth_handler <- handler(type = 'BIRTH', FUN = set_birth_date)
#' death_handler <- handler(type = 'DEATH', FUN = set_death_date)
#'
#' handlers <- handlers_list(birth_handler, death_handler)
#'
#' the_dispatcher <- dispatcher(handlers)
#'
#' dispatch <- get_dispatch(the_dispatcher)
#'
#' events <- event_list(birth_event, death_event)
#'
#' the_obj <- dispatch(events = events, accumulate = FALSE)
#' the_obj
#'
#' the_obj <- dispatch(events = events, accumulate = TRUE)
#' the_obj
#'
#' # transform the_obj to data.frame
#' the_obj %>%
#'   purrr::map(as.data.frame) %>%
#'   bind_rows
#'
#' @rdname dispatcher
#' @export
dispatcher = function(handlers) {

  stopifnot(validate_dispatcher(handlers))

  .dispatcher <- new_dispatcher(handlers)

  return(.dispatcher)

}

#' @rdname dispatcher
#' @export
new_dispatcher <- function(handlers){

  li <- list(

    handlers = handlers,

    dispatch = function(obj = NULL, events, accumulate = FALSE){

      FUN = function(obj, event){

        handlers_types <- get_type(handlers)
        w <- which(handlers_types == get_type(event))
        f <- get_fun(handlers)[[w]]
        f(obj, event)

      }

      obj <- Reduce(FUN, events, init = obj, accumulate = accumulate)

      return(obj)

    }

  )

  out <- structure(.Data = li, class = c('dispatcher', 'list'))

  return(out)

}

#' @rdname dispatcher
#' @export
validate_dispatcher <- function(handlers) {

  out <- is_handlers_list(handlers)
  return(out)

}

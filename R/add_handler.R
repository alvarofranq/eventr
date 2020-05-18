#' @title Add Handler
#'
#' @description Merge two handler objects or add a handler in a handlers_list or dispatcher objects.
#'
#' @param obj A handler, handler_list or dispatcher object.
#' @param .handler A handler object.
#'
#' @return Retun a \code{handlers_list} object.
#'
#' @examples
#'
#' library(eventr)
#' library(magrittr)
#'
#' birth_handler <- handler(type = 'BIRTH', FUN = function(obj, event){
#'   obj$birth_date <- get_body_attr(event, 'birth_date')
#'   return(obj)
#' })
#'
#' measurement_handler <- handler(type = 'MEASUREMENT', FUN = function(obj, event){
#'
#'   obj$weight <- get_body_attr(event, 'weight')
#'   obj$height <- get_body_attr(event, 'height')
#'   return(obj)
#'
#' })
#'
#' death_handler <- handler(type = 'DEATH', FUN = function(obj, event){
#'   obj$death_date <- get_body_attr(event, 'death_date')
#'   return(obj)
#' })
#'
#' handlers <- add_handler(birth_handler, death_handler)
#'
#' handlers_01 <- birth_handler %>%
#'   add_handler(measurement_handler) %>%
#'   add_handler(death_handler)
#'
#' handlers_02 <- birth_handler +
#'   measurement_handler +
#'   death_handler
#'
#' identical(handlers_01, handlers_02)
#'
#' @export
add_handler <- function(obj, .handler) { UseMethod("add_handler") }

#' @export
add_handler.list <- function(obj, .handler) {

  li <- c(obj, list(.handler))
  li <- do.call('handlers_list', args = li)
  return(li)

}

#' @export
add_handler.handler <- function(obj, .handler) return(handlers_list(obj, .handler))

#' @export
add_handler.handlers_list <- function(obj, .handler) {

  handlers_list_types <- get_type(obj)

  new_handler_type <- get_type(.handler)

  if(any(new_handler_type %in% handlers_list_types)){
    w <- which(new_handler_type %in% handlers_list_types)
    obj <- obj[-w]
  }

  h1 <- purrr::map(obj, function(o) return(o))

  if (is_handler(.handler) & length(.handler) == 2) args = c(h1, list(.handler))
  else if (is_handlers_list(.handler)) {

    h2 <- purrr::map(.handler, function(h) return(h))
    args = c(h1, h2)

  }

  out <- do.call('handlers_list', args = args)

  return(out)
}

#' @export
add_handler.dispatcher <- function(obj, .handler){

  handlers <- c(get_handlers(obj), .handler)

  .dispatcher <- dispatcher(handlers)

  return(.dispatcher)

}

#' @title Add handlers to a handlers_list
#'
#' @description Merge two handler objects or add a handler in a handlers_list or dispatcher objects.
#'
#' @param e1 A handler, handler_list or dispatcher object.
#' @param e2 A handler or handlers_list object.
#'
#' @return Retun a \code{handlers_list} object.
#'
#' @examples
#'
#' library(eventr)
#' library(magrittr)
#'
#' birth_handler <- handler(type = 'BIRTH', FUN = function(obj, event){
#'   obj$birth_date <- get_body_attr(event, 'birth_date')
#'   return(obj)
#' })
#'
#' measurement_handler <- handler(type = 'MEASUREMENT', FUN = function(obj, event){
#'
#'   obj$weight <- get_body_attr(event, 'weight')
#'   obj$height <- get_body_attr(event, 'height')
#'   return(obj)
#'
#' })
#'
#' death_handler <- handler(type = 'DEATH', FUN = function(obj, event){
#'   obj$death_date <- get_body_attr(event, 'death_date')
#'   return(obj)
#' })
#'
#' handlers <- birth_handler +
#'   measurement_handler +
#'   death_handler
#'
#' @rdname handler-add
#' @export
"+.handler" <- function(e1, e2) {

  add_handler(e1, e2)

}

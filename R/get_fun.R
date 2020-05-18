#' @title Get Function
#'
#' @description Get the function in a handler, handler_list or dispatcher objects.
#'
#' @param obj An object of type handler, handler_list or dispatcher.
#'
#' @return Returns a function
#'
#' @examples
#'
#' set_birth_date <- function(obj, event){
#'   obj$birthDate <- event$body$birthDate
#'   return(obj)
#' }
#'
#' set_death_date <- function(obj, event){
#'   obj$deathDate <- event$body$deathDate
#'   return(obj)
#' }
#'
#' birth_handler <- handler(type = 'BIRTH', FUN = set_birth_date)
#' get_fun(birth_handler)
#'
#' death_handler <- handler(type = 'DEATH', FUN = set_death_date)
#' get_fun(death_handler)
#'
#' handlers <- handlers_list(birth_handler, death_handler)
#' get_fun(handlers)
#'
#' @export
get_fun <- function(obj) { UseMethod("get_fun") }

#' @export
get_fun.handler <- function(obj) obj[['FUN']]

#' @export
get_fun.handlers_list <- function(obj) purrr::map(obj, get_fun)

#' @export
get_fun.dispatcher <- function(obj) {

  handlers <- get_handlers(obj)
  funs <- get_fun(handlers)
  return(funs)

}

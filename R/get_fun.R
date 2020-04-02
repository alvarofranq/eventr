#' @title Get Function
#'
#' @description Get the function in a handler, handler_list or dispatcher objects.
#'
#' @param obj An object of tipe `handler`, `handler_list` or `dispatcher`.
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

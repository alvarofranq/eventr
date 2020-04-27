#' @title Handler List Constructor
#'
#' @description A handler list constructor. The function validates the structure of
#' the input params and creates a handlers_list object.
#'
#' @param ... A set of handler objects.
#'
#' @return The \code{handlers_list()} function returns a list of \code{handlers} objects.
#'
#' @examples
#'
#' measurement_handler <- handler(
#'   type = 'MEASUREMENT',
#'   FUN = function(obj, event) {
#'     obj$measurement = get_attr(event, 'measurement')
#'    return(obj)
#'   }
#' )
#'
#' bmi_handler <- handler(
#'   type = 'BMI',
#'   FUN  = function(obj, event) {
#'
#'    obj$imc <- get_attr(event, 'mass') / get_attr(event, 'height')^2
#'    return(obj)
#'
#'   }
#' )
#'
#' handlers <- handlers_list(measurement_handler, bmi_handler)
#'
#' @rdname handlers_list
#' @export
handlers_list <- function(...){

  stopifnot(validate_handlers_list(...))

  .handlers_list <- new_handlers_list(...)
  return(.handlers_list)

}

#' @rdname handlers_list
#' @export
validate_handlers_list <- function(...){

  li <- list(...)

  check_ellipsis <- purrr::map_lgl(li, is_handler)

  handlers_list_types <- get_type(li)
  check_one_handler_by_type <- length(li) == length(unique(handlers_list_types))

  if(!all(check_ellipsis)) { stop("All the list objects must be handlers.")}

  return(all(check_ellipsis))

}

#' @rdname handlers_list
#' @export
new_handlers_list <- function(...){

  li <- list(...)

  .handlers_list <- structure(
    .Data = li,
    class = c('handlers_list', 'list')
  )

  return(.handlers_list)


}

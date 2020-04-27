#' @title Handler Constructor
#'
#' @description Construct a handler object.
#'
#' @param type A character string indicating the event type to handle.
#' @param FUN A function which use an obj and an event as input parameters and returns an object as output.
#'
#' @return The \code{handler()} function returns an object of type \code{handler}. A \code{handler} object
#' contains two elements: \code{type} and \code{FUN}. Type is a string indicating the type of event and FUN
#' is a \code{R} function with to params: \code{obj} and \code{event}. \code{obj} is any R object and
#' \code{event} is an \code{event} object returned by the \code{event()} function.
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
#' birth_handler
#'
#' death_handler <- handler(type = 'DEATH', FUN = set_death_date)
#' death_handler
#'
#' @export
handler <- function(type, FUN){

  validate_handler(type, FUN)

  .handler <- new_handler(type, FUN)

  return(.handler)

}

#' @rdname handler
#' @export
new_handler <- function(type, FUN){

  .handler <- structure(
    .Data = list(type = type, FUN = FUN),
    class = c('handler', 'list')
  )

  return(.handler)
}

#' @rdname handler
#' @export
validate_handler <- function(type, FUN){

  # check type
  stopifnot(is.character(type))

  # check if FUN has an obj and an event has params.
  FUN_params <- names(formals(FUN))

  if(FUN_params[[1]] != "obj") {
    stop("The name of the first parameter of the FUN function must be obj")
  }
  else if(FUN_params[[2]] != "event") {
    stop("The name of the second parameter of the FUN function must be event")
  }

}

#' @title Handler Constructor
#'
#' @description Construct a Handler object
#'
#' @param type A character string indicating the event type to handle
#' @param FUN A function which use an obj and a event as inputs and returns an object as output
#'
#' @examples
#' setBirthDate <- function(obj, event){
#'   obj$birthDate <- event$body$birthDate
#'   return(obj)
#' }
#'
#' setDeathDate <- function(obj, event){
#'   obj$deathDate <- event$body$deathDate
#'   return(obj)
#' }
#'
#' birthHandler <- handler(type = 'BIRTH', FUN = setBirthDate)
#' deathHandler <- handler(type = 'DEATH', FUN = setDeathDate)
#'
#' handlers <- append(birthHandler, deathHandler)
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

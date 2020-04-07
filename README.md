
# eventr

<!-- badges: start -->
<!-- badges: end -->

The goal of eventr is to ...

## Installation

You can install the released version of eventr from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("eventr")

# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("tidyverse/ggplot2")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r

library(eventr)
library(dplyr)

birth_event <- event(
  id = 'first-id',
  type = 'BIRTH',
  time = '1936-11-09',
  birth_date = '1936-11-09'
)

death_event <- event(
  id = 'second-id',
  type = 'DEATH',
  time = '2019-05-22',
  death_date = '2019-05-22'
)

set_birth_date <- function(obj, event){
  obj$birth_date <- get_body_attr(event, "birth_date")
  return(obj)
}

set_death_date <- function(obj, event){
  obj$death_date <- get_body_attr(event, "death_date")
  return(obj)
}

birth_handler <- handler(type = 'BIRTH', FUN = set_birth_date)
death_handler <- handler(type = 'DEATH', FUN = set_death_date)

handlers <- handlers_list(birth_handler, death_handler)

the_dispatcher <- dispatcher(handlers)

dispatch <- get_dispatch(the_dispatcher)

events <- event_list(birth_event, death_event)

the_obj <- dispatch(events = events, accumulate = FALSE)
the_obj

the_obj <- dispatch(events = events, accumulate = TRUE)
the_obj

# transform the_obj to data.frame
the_obj %>%
  purrr::map(as.data.frame) %>%
  bind_rows
  
```


#' Create simple tweens
#'
#' This set of functions can be used to interpolate between single data types,
#' i.e. data not part of data.frames but stored in vectors. All functions come
#' in two flavours: the standard and a *_t version. The standard reads the data
#' as a list of states, each tween matched element-wise from state to state. The
#' *_t version uses the transposed representation where each element is a vector
#' of states. The standard approach can be used when each tween has the same
#' number of states and you want to control the number of point in each state
#' transition. The latter is useful when each tween consists of different
#' numbers of states and/or you want to specify the total number of points for
#' each tween.
#'
#' @section Difference Between `tween_numeric` and `approx()`:
#' `tween_numeric` (and `tween_numeric_t`) is superficially equivalent to
#' [stats::approx()], but there are differences.
#' [stats::approx()] will create evenly spaced points, at the expense
#' of not including the actual points in the input, while the reverse is true
#' for `tween_numeric`. Apart from that `tween_numeric` of course supports easing
#' functions and is vectorized.
#'
#' @details
#' `tween` and `tween_t` are wrappers around the other functions that tries to guess
#' the type of input data and choose the appropriate tween function. Unless you
#' have data that could be understood as a colour but is in fact a character
#' vector it should be safe to use these wrappers. It is probably safer and more
#' verbose to use the explicit functions within package code as they circumvent
#' the type inference and checks whether the input data matches the tween
#' function.
#'
#' `tween_numeric` will provide a linear interpolation between the points based on
#' the sequence returned by the easing function. `tween_date` and `tween_datetime`
#' converts to numeric, produces the tweening, and converts back again.
#' `tween_colour` converts colours into Lab and does the interpolation there,
#' converting back to sRGB after the tweening is done. `tween_constant` is a
#' catchall that converts the input into character and interpolates by switching
#' between states halfway through the transition.
#'
#' The meaning of the `n` and `ease` arguments differs somewhat
#' between the standard and *_t versions of the functions. In the standard
#' function `n` and `ease` refers to the length and easing function of
#' each transition, being recycled if necessary to `length(data) - 1`. In
#' the *_t functions `n` and `ease` refers to the total length of each
#' tween and the easing function to be applied to all transition for each tween.
#' The will both be recycled to `length(data)`.
#'
#' @param data A list of vectors or a single vector. In the standard functions
#' each element in the list must be of equal length; for the *_t functions
#' lengths can differ. If a single vector is used it will be eqivalent to using
#' `as.list(data)` for the standard functions and `list(data)` for the
#' *_t functions.
#'
#' @param n The number of elements per transition or tween. See details
#'
#' @param ease The easing function to use for each transition or tween. See
#' details. Defaults to `'linear'`
#'
#' @return A list with an element for each tween. That means that the length of
#' the return is equal to the length of the elements in `data` for the
#' standard functions and equal to the length of `data` for the *_t
#' functions.
#'
#' @examples
#' tween_numeric(list(1:3, 10:8, c(20, 60, 30)), 10)
#'
#' tween_colour_t(list(colours()[1:4], colours()[1:2], colours()[25:100]), 100)
#'
#' @export
#'
tween <- function(data, n, ease = 'linear') {
  type <- guessType(data)
  switch(
    type,
    numeric = tween_numeric(data, n, ease),
    date = tween_date(data, n, ease),
    datetime = tween_datetime(data, n, ease),
    colour = tween_colour(data, n, ease),
    tween_constant_t(data, n, ease)
  )
}
#' @rdname tween
#' @export
tween_t <- function(data, n, ease = 'linear') {
  type <- guessType(data)
  switch(
    type,
    numeric = tween_numeric_t(data, n, ease),
    date = tween_date_t(data, n, ease),
    datetime = tween_datetime_t(data, n, ease),
    colour = tween_colour_t(data, n, ease),
    tween_constant_t(data, n, ease)
  )
}
guessType <- function(data) {
  data <- unlist(data)
  col_classes(list(data))
}

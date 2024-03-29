% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aaa.R, R/gen.R, R/gen_keyframe.R
\docType{data}
\name{col_classes}
\alias{col_classes}
\alias{gen_internal}
\alias{PHASE_LEVELS}
\alias{is_generator}
\alias{generator_settings}
\alias{generator_settings<-}
\alias{ease_type}
\alias{ease_type<-}
\alias{col_types}
\alias{col_types<-}
\alias{gen_data}
\alias{gen_data<-}
\alias{gen_to_data_frame}
\alias{data_frame_to_gen}
\alias{keyframes}
\alias{keyframes<-}
\alias{frame_times}
\alias{frame_times<-}
\title{Generator internals}
\format{
An object of class \code{character} of length 5.
}
\usage{
col_classes(data)

PHASE_LEVELS

is_generator(x)

generator_settings(x)

generator_settings(x) <- value

ease_type(x)

ease_type(x) <- value

col_types(x)

col_types(x) <- value

gen_data(x)

gen_data(x) <- value

gen_to_data_frame(...)

data_frame_to_gen(x)

keyframes(x)

keyframes(x) <- value

frame_times(x)

frame_times(x) <- value
}
\arguments{
\item{x}{A generator object}
}
\value{
Various data
}
\description{
Generator internals
}
\keyword{datasets}
\keyword{internal}

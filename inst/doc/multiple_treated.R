## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  out.width = '90%', 
  out.height = '600px',
  fig.align='center'
)
set.seed(123)

## ----original_figure, echo = FALSE, fig.cap = "Figure 1: Xu, Yiqing, 2017", out.height = '400px'----
knitr::include_graphics(path = "https://ignacio.martinez.fyi/synthetic_control/gsynth.png")


## ----setup, out.height = '800px'----------------------------------------------
library(bsynth)
ci_width <- 0.95
data(gsynth, package = "gsynth")
dplyr::glimpse(simdata)

outcome_data <- simdata %>% 
  dplyr::select(time, id, D, Y)

covariates <- simdata %>% 
  dplyr::select(time, id, X1, X2)

synth <-
  bsynth::bayesianSynth$new(
    data = outcome_data,
    time = time,
    id = id,
    treated = D,
    outcome = Y, 
    ci_width = ci_width,
    covariates = covariates
  )

synth$timeTiles +
  ggplot2::theme(text = ggplot2::element_text(size=6))


## ----fit, results="hide"------------------------------------------------------
synth$fit()

## -----------------------------------------------------------------------------
synth$synthetic  

## -----------------------------------------------------------------------------
synth$effectPlot(subset = c("Average"), facet = FALSE) + 
  ggplot2::scale_y_continuous(breaks=seq(-2,12,2))


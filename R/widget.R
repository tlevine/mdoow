#' @export
#' @import htmltools
#' @import htmlwidgets

mdoow <- function(x, samp.rate = 44100, host = '0.0.0.0', port = 9888) {
  mdoow.env <- new.env()
  browseURL('inst/index.html', 'firefox')
  function(loops) mdoow.push(mdoow.env, loops, samp.rate, host, port)
}

#' @export
mdoowOutput <- function(outputId, width = "60px", height = "20px") {
  htmlwidgets::shinyWidgetOutput(outputId, "mdoow", width, height)
}

#' @export
renderMdoow <- function(expr, env = parent.frame(), quoted = FALSE) {
  htmlwidgets::shinyRenderWidget(expr, mdoowOutput, env, quoted = TRUE)
}

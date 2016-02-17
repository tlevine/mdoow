deps <- c('httpuv', 'tuneR')
for (dep in deps) {
  suppressMessages(library(dep, character.only = TRUE))
  unloadNamespace(dep)
}

#' Generate an app specification for httpuv
#'
#' @param state An environment
#' @returns list See httpuv::startServer
app <- function(state) list(
  call = http.call,
  onWSOpen = function(ws) {
    state$ws <- ws
  }
)

#' Push a new set of loops to the player.
#'
#' @param loops data.frame of numeric vectors with values between -1 and 1
mdoow.push <- function(mdoow.env, loops, samp.rate, host, port) {
  if (!('server' %in% names(mdoow.env))) {
    mdoow.env$server <- httpuv::startServer(host, port, app(mdoow.env))
    on.exit(httpuv::stopServer(mdoow.env$server))
  }
  if (is.data.frame(loops)) {
    n <- nrow(loops)
    vec <- colSums(loops)
  } else {
    n <- length(loops)
    vec <- loops
  }
  
  if ('ws' %in% names(mdoow.env)) {
    mdoow.env$ws$send(as.wave(vec, samp.rate))

    # Wait almost a full loop
    end.time <- Sys.time() + 0.9 * n / samp.rate
    while (Sys.time() < end.time) service()
  } else {
    warning('Socket is not open, so we are not sending data.')
  }
}


#' Convert a numeric vector into a wave file.
#'
#' @param sound Numeric vector of speaker positions, with range of -1 to 1
#' @returns raw of the file
as.wave <- function(sound, samp.rate) {
  wave.numeric <- tuneR::Wave(sound, numeric(0), samp.rate = samp.rate, bit = 16) * 32767
  filename <- tempfile(fileext = '.wav')
  tuneR::writeWave(wave.numeric, filename)
  con <- file(filename, open = 'rb')
  wave.raw <- readBin(con, 'raw', n = length(wave.numeric@left) * 2)
  unlink(filename)
  wave.raw
}

http.call <- function(req) {
  wsUrl = paste0("ws://", ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST))
  list(
    status = 200L,
    headers = list(
      'Content-Type' = 'text/plain'
    ),
    body = wsUrl
  )
}

mdoow <- function(x, samp.rate = 44100, host = '0.0.0.0', port = 9888) {
  mdoow.env <- new.env()
  browseURL('inst/index.html', 'firefox')
  function(loops) mdoow.push(mdoow.env, loops, samp.rate, host, port)
}

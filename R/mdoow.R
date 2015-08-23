deps <- c('httpuv', 'tuneR')
for (dep in deps) {
  suppressMessages(library(dep, character.only = TRUE))
  unloadNamespace(dep)
}

#' Push a new set of loops to the player.
#'
#' @param loops data.frame of numeric vectors with values between -1 and 1
mdoow <- function(loops, samp.rate = 44100,
                  host = '0.0.0.0', port = 8888,
                  env = new.env()) {
  if (!('server' %in% names(env))) {
    env$server <- startServer(host, port, app(env))
    on.exit(stopServer(env$server))
  }
  env$ws$send(as.wave(colSums(loops), samp.rate))
  service(900 * nrow(loops) / samp.rate) # Wait almost a full loop
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

#' Generate an app specification for httpuv
#'
#' @param state An environment
#' @returns list See httpuv::startServer
app <- function(state) list(
  call = function(req) {
    wsUrl = paste0("ws://", ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST))
    list(
      status = 200L,
      headers = list(
        'Content-Type' = 'text/plain'
      ),
      body = wsUrl
    )
  },
  onWSOpen = function(ws) {
    state$ws <- ws
  }
)

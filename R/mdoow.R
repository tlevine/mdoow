#' Push a new set of loops to the player.
#'
#' @param loops data.frame of numeric vectors with values between -1 and 1
mdoow <- function(loops, samp.rate = 44100,
                  host = '0.0.0.0', port = 8888
                  env = new.env()) {
  if (!('server' %in% names(env))) {
    env$server <- startServer(host, port, app(env))
    on.exit(stopServer(env$server))
  }
  env$ws$send(as.wave(colSums(loops), samp.rate))
  service(900 * nrow(loops) / samp.rate) # Wait almost a full loop
}

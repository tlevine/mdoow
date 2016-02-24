BITRATE = 8000 # per second
BUFFER = 1/12 # seconds
options(digits.secs = 9)

#' @export
loop <- function(next.sample, prev.time = NULL) {
  if (is.null(prev.time))
    next.time <- Sys.time()
  else
    next.time <- prev.time + length(next.sample) / BITRATE

  if (next.time - (BITRATE * BUFFER) < Sys.time()) {
    cat('XXX Write to /dev/dsp\n')
    function(x) loop(x, prev.time = next.time)
  }
}

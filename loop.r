BITRATE = 8000 # per second
BUFFER = 1/12 # seconds
options(digits.secs = 9)

service.loop <- function(next.sample,
                         prev.time = NULL, prev.sample = NULL) {
  if (is.null(prev.time) || is.null(prev.sample))
    next.time <- Sys.time()
  else
    next.time <- prev.time + next.sample / BITRATE

  if (next.time - (BITRATE * BUFFER) < Sys.time()) {
    # XXX Write to /dev/dsp
    function(x) service.loop(x, prev.time = next.time,
                             next.sample = prev.sample)
  }
}

#' @export
loop <- function(first.sample) service.loop(first.sample)

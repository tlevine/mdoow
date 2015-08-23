#' Convert a numeric vector into a wave file.
#'
#' @param sound Numeric vector of speaker positions, with range of -1 to 1
#' @returns raw of the file
as.wave <- function(sound, samp.rate) {
  raw.wave <- tuneR::Wave(sound, numeric(0), samp.rate = samp.rate, bit = 16)
  normalized.wave <- tuneR::normalize(w, unit = '16')
  filename <- tempfile(fileext = '.wav')
  tuneR::writeWave(w, filename)
  unlink(filename)
}



score$loops <- data.frame(x = rep(0, 44100))
score$samp.rate <- 44100

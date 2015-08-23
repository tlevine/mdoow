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

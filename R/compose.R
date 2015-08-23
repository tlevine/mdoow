SECOND <- 44100

wave <- function(left = numeric(0), right = numeric(0),
                 sampling.rate = SECOND, bit = 16,
                 fade = fade.quadratic)
  tuneR::Wave(left, right,
              samp.rate = sampling.rate, bit = bit)

#' Convert a numeric vector into a wave file.
#'
#' @param sound Numeric vector of speaker positions, with range of -1 to 1
#' @returns raw of the file
as.wave <- function(sound, filename, samp.rate = SECOND) {
  raw.wave <- tuneR::Wave(sound, numeric(0), samp.rate = samp.rate, bit = 16)
  normalized.wave <- tuneR::normalize(w, unit = '16')
  tuneR::writeWave(w, filename)
}



score$loops <- data.frame(x = rep(0, 44100))
score$samp.rate <- 44100

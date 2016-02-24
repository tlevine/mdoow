t <- 1:4000

A4 <- sin(440 * t * 2 * pi / 8000)
noise <- floor(runif(length(t), -1, 1))
silence <- rep(0, 4000)

# scale.wave <- function(x)
#   -1 + 2 * ((x - min(x)) / (max(x) - min(x)))

U8 <- function(x) {
  if (any(is.na(x)) || min(x) < -1 || max(x) > 1)
    stop('You must normalize and remove NAs.')
  else
    as.raw(128 + floor(x*127.5))
}

dsp <- file('/dev/dsp', open = 'wb')
writeBin(U8(A4), dsp)
close(dsp)

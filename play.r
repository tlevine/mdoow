t <- 1:8000
A4 <- sin(440 * t * 2 * pi / 8000)

U8 <- function(x) floor((x+1)*127.5)
noise <- floor(runif(length(t), 0, 255))
silence <- rep(127, 8000)

dsp <- file('/dev/dsp', open = 'wb')
writeBin(as.raw(U8(A4)), dsp)
close(dsp)

.mdoow.state <- new.env()

mdoow <- function(loops, samp.rate = 44100) {
  as.wave(colSums(loops))
}

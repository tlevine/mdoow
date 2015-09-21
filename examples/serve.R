source('R/mdoow.R')
library(httpuv)

# readBin(file('music.wav', 'rb'), 'raw', n = file.info('music.wav')$size) -> a

app <- list(call = http.call)

mdoow(iris[-5])

stopServer(handle)


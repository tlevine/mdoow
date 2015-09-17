source('R/mdoow.R')
library(httpuv)

app <- list(call = http.call)
handle <- startServer('0.0.0.0', 8888, app)

mdoow(iris[-5])

stopServer(handle)

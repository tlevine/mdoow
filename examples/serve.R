source('R/mdoow.R')
library(httpuv)

app <- list(call = http.call)
handle <- startServer('0.0.0.0', 8888, app)

replicate(10, service())
mdoow(iris[-5])

stopServer(handle)

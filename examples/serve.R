source('R/mdoow.R')
library(httpuv)

app <- list(call = http.call)

mdoow(iris[-5])

stopServer(handle)

library(httpuv)

app <- list(
  call = function(req) {
  # wsUrl = paste(sep='',
  #               '"',
  #               "ws://",
  #               ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST),
  #               '"')
    list(
      status = 200L,
      headers = list(
        'Content-Type' = 'text/html'
      ),
      body = '<html>Hi</html>'
    )
  },
  onWSOpen = function(ws) {
    ws$onMessage(function(binary, message) {
      ws$send(message)
    })
  }
)

host <- '0.0.0.0'
port <- 9454
runServer(host, port, app)

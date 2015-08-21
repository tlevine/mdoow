library(httpuv)

state <- new.env()
state$rendered.score <- 0 # Put a wave file with a second of silence here.

app <- list(
  call = function(req) {
    wsUrl = paste0("ws://", ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST))
    list(
      status = 200L,
      headers = list(
        'Content-Type' = 'text/plain'
      ),
      body = wsUrl
    )
  },
  onWSOpen = function(ws) {
    ws$onMessage(function(binary, message) {
      ws$send(state$rendered.score)
    })
  }
)

host <- '0.0.0.0'
port <- 9454

server <- startServer(host, port, app)
on.exit(stopServer(server))


# .globals$stopped <- FALSE
# while (!.globals$stopped) {
#     service(100)
#     Sys.sleep(0.001)
# }

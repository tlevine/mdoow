library(httpuv)

app <- function(state) list(
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
    state$ws <- ws
  }
)

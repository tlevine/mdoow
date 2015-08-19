library(httpuv)

app <- list(
  call = function(req) {
    wsUrl = paste0("ws://", ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST))
    list(
      status = 200L,
      headers = list(
        'Content-Type' = 'text/html'
      ),
      body = sprintf('
<html>
<script>
var ws = new WebSocket("%s")
ws.onmessage = function(msg) {
  var msgDiv = document.createElement("pre");
  alert(msg.data)
}
function sendInput() {
  var input = document.getElementById("input");
  ws.send(input.value);
  input.value = "";
}
</script>
<h3>Send Message</h3>
<form action="" onsubmit="sendInput(); return false">
<input type="text" id="input"/>
</html>', wsUrl)
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

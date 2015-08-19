/*
var audioCtx = new AudioContext();
var buffer = audioCtx.createBuffer(2, 22050, 44100);
var source = audioCtx.createBufferSource();
source.buffer = buffer;
source.connect(audioCtx.destination);
source.start();
*/


var audioCtx = new AudioContext();
source = audioCtx.createBufferSource();
request = new XMLHttpRequest();
request.open('GET', 'music.wav', true);
request.responseType = 'arraybuffer';
request.onload = function() {
  audioData = request.response
  audioCtx.decodeAudioData(audioData, function(buffer) {
    source.buffer = buffer;
    source.connect(audioCtx.destination);
    source.loop = true;
  })
}
request.send();
source.start(0);



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

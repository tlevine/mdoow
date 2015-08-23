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


module.exports = function(ws) {
  ws.onmessage = function(msg) {
    alert(msg.data)
  }
}

var http = require('http');

// hey there is no sleep in javascript better make one

function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.write('hello World\n');
    sleep(30000);
    res.write('OK');
    res.end();
}).listen(3000, "127.0.0.1");
console.log('Server running at http://127.0.0.1:3000/');



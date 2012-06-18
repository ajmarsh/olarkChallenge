var http = require('http');
 
http.createServer(function (request, response) {
    setTimeout(function(){
        response.writeHead(200, {'Content-Type': 'text/plain'});
        response.write('OK');
        response.end();}, 30000);
}).listen(3000, "127.0.0.1");
console.log('Server running at http://127.0.0.1:3000/');

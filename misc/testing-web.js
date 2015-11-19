var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('<h1 style="color: #4488ff;">Free Server is online :)</h1> \n');
}).listen(80, '0.0.0.0');
console.log('Server running at http://localhost/');

GLOBAL.Class = require('./system/Class');
GLOBAL.config = require('./config');
GLOBAL.Controller = require('./system/Controller');
Controller.getControllers();

var http = require('http');
var Router = require('./system/Router');
var router = Router();
var contorllers = Controller.content;
//===========================================================
//
var _static = function _static(request, response, after){
  var mime = require('./system/Mime');
  var path = require('path');
  var fs = require('fs');

  var pathname = request.url.replace(/\?.*$/, '');

  if (/\/$/.test(pathname))
    pathname = path.join(pathname , 'index.html');

  var realPath = path.join(config.static_folder, path.resolve(pathname));
  var ext = path.extname(realPath);
  ext = ext ? ext.slice(1) : 'unknown';
  

  fs.exists(realPath, function (exists) {
    if (!exists) {
      after(request, response);
    } else {
      fs.readFile(realPath, "binary", function (err, file) {
        if (err) {
        after(request, response);
        } else {
          response.writeHead(200, {
            'Content-Type': mime[ext] || 'text/plain'
          });
          response.write(file, "binary");
          response.end();
        }
      });
    }
  });

};

var _dispatcher = function _dispatcher(request, response){

  var parsed = router.parse(request.url);
  var controller = contorllers[parsed['parsed']['controller']];

  if (!controller){
    response.end('controller not found');
    return;
  }
    
  var action = controller[parsed['parsed']['action']];
  if (typeof action !== 'function'){
    response.end('action not found');
    return;
  }
  else {
    controller.request = request;
    controller.response = response;
    controller.parsed = parsed;
    action.apply(controller, parsed['parsed']['arguments']);
  }

};

var server = http.createServer(function(request, response){
  _static(request, response, _dispatcher);
  //_dispatcher(request, response);
});

server.listen(config.port);
console.log('Server running at port: ' + config.port);

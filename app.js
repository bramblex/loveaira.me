
var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var logger = require('morgan');

var path = require('path')
//var mongoose = require('mongoose');

global.config = require('./config');
global._ = require('lodash');

app.use(logger());

app.use('/', express.static(path.join(__dirname, 'www')));

app.get('/api', function(req, res, next){
  res.send('Api\'s here!');
});

// soket.io
io.on('connection', function(socket){
  console.log('on connections');
});

// peerjs
var peer_server = require('peer').ExpressPeerServer;
app.use('/peer', peer_server(server, {debug: true}));

// port
console.log('Listen to port:', config.port);
app.listen(config.port);

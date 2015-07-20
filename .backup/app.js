#!/usr/local/bin/node

var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var logger = require('morgan');
var session = require('express-session');

var path = require('path')
//var mongoose = require('mongoose');

global.config = require('./config');
global._ = require('lodash');

//app.use(session({
  //genid: function(req) {
    //return genuuid();
  //},
  //secret: 'I am a keyboard cat',
//}));

app.use(logger());

//app.use('/', function(res, req, next){
  //setTimeout(function(){
    //next();
  //}, 500);
//});
app.use('/', express.static(path.join(__dirname, 'www')));

var api_resource = express.Router();
//api_resource.get('/user',);
//api_resource.git('/post',);

app.use('/api', api_resource);

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

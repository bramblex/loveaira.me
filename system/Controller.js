var path = require('path');
var LoadAll = require('./LoadAll');

var Controller = Class('Controller', Object);
Controller.getControllers = function getControllers(){
  this.content = LoadAll(path.join(config.base_path, config.controllers_folder));
};
module.exports = Controller;

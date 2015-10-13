var path = require('path');
var fs = require('fs');

//var Template = Class('Template', Object);

Template = {};

Template.__cached__ = {};

Template.compile = function compile(template){
  return template;
}

Template.cache = function cache(template_path){
  var real_template_path = path.join(config.template_folder, template_path);
  var template = this.__cached__[real_template_path];
  if (!template){
    this.__cached__[real_template_path] = this.compile(
      fs.readFileSync('real_template_path', 'utf8')
    );
  }
  return this.__cached__[real_template_path];
};


Template.render = function render(template_path, values){
};

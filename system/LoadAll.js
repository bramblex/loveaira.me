
(function(__root__, __define__){
  var define = function define(dependencies, factory) {

    var factory = factory || dependencies;
    var dependencies = (Array.isArray(dependencies) && dependencies) || [];

    if ( typeof __define__ === 'function' && __define__.amd){
      __define__(dependencies, factory);
    } else if ( typeof __define__ === 'function' && __define__.cmd){
      __define__(dependencies, function(require, exports, module){
        module.exports = factory.apply(__root__, dependencies.map(function(m){
          return require(m);
        }));
      });
    } else if (typeof exports === 'object'){
      module.exports = factory.apply(__root__, dependencies.map(function(m){
        return require(m);
      }));
    } else{
      var name = document.currentScript.src.replace(/(^.*?)([^\/]+)\.(js)(\?.*$|$)/, '$2');
      name = name.replace('.min', '');
      __root__[name] = factory.apply(__root__, dependencies.map(function(m){
        return __root__[m.replace(/^.*\//, '')];
      }));
    }
  };

  
// nodejs / iojs only.
define(function(){

  var path = require('path');
  var fs = require('fs');
  var isjs = /\.js$/

  return function ReuqireAll(dir){
    var result = {};
    var files = fs.readdirSync(dir);

    files
    .filter(function(item){
      return isjs.test(item);
    })
    .map(function(item){
      return item.replace(isjs, '');
    })
    .forEach(function(item, index, self){
      var name = path.basename(item);
      var module_path = path.resolve((path.join(dir, item)));

      result[name] = require(module_path)();
    });

    return result;
  }

});


})(this, typeof define !== 'undefined' && define);

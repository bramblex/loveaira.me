
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

  
define(['./Class'], function(Class){

  var History = Class('History', Array);

  History.method('top', function(){
    return this[this.length-1];
  });
  
  var Router = Class('Router', Object);

  Router
  .method('constructor', function(){
    //Router.uper('constructor').apply(this);
    this.default_controller = 'main';
    this.default_action = 'index';
    this.history = null;
  })
  .method('parse', function(url){

    var result = {};
    result.url = url;

    var tmp = url.split('?');
    var pathname = tmp[0];
    var querystring = tmp[1];

    result['pathname'] = pathname.replace(/\/{2,}/g, '/');
    result['querystring'] = querystring;

    if (querystring && querystring.length){
      var args = {};
      querystring.split('&').forEach(function(item, index, self){
        var matched = item.match(/(.*)=(.*)/);
        if (matched)
          args[matched[1]] = matched[2];
      });
      result.args = args;
    }

    var parsed = pathname.split('/').filter(function(item){return item.length});

    result.parsed = {
      controller : parsed[0] || this.default_controller , 
      action: parsed[1] || this.default_action, 
      arguments: parsed.slice(2)
    };

    if (this.history){
      this.history.push(result);
    }

    return result;
  })

  .method('setHistory', function(){
    this.history = History();
  })

  .method('back', function(){
    var history = this.history;
    if (history){
      history.pop();
    }
    return history.top();
  });

  Router.History = History;
  return Router;

});


})(this, typeof define !== 'undefined' && define);

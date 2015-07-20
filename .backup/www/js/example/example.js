
(function(__root__, __define__){

  var define = function define(dependencies, factory) {

    var factory = factory || dependencies;
    var dependencies = (Array.isArray(dependencies) && dependencies) || [];

    if ( typeof __define__ === 'function' && __define__.amd){
      __define__(dependencies, factory);
    } else if (typeof exports === 'object'){
      module.exports = factory.apply(__root__, dependencies.map(function(m){
        return require(m);
      }));
    } else{
      var name = document.currentScript.src.replace(/(^.*?)([^\/]+)\.js(\?.*$|$)/, '$2');
      __root__[name] = factory.apply(__root__, dependencies.map(function(m){
        return __root__[m.replace(/^.*\//, '')];
      }));
    }
  };

  
define(['./lib1', './lib2'], function(lib1,lib2){
  var myFunc = function myFunc(){
    console.log('example');
  };

  myFunc.lib1 = lib1;
  myFunc.lib2 = lib2;

  return myFunc;
});



})(this, typeof define !== 'undefined' && define);

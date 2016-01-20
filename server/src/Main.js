"use strict"
// module Main
//exports.encodeURIComponent = encodeURIComponent;
//exports.random = function(){
  //return Math.random();
//};
exports.alert = function(msg){
  return function(){
    window.alert(msg);
    return {};
  };
};


;(function(BlxClass, EventEmitter){
  'use strict';
  var RESOLVED = 0,
    REJECTED = 1,
    PENDING = 2,
    TIMEOUT = 3;

  var BlxPromise = BlxClass(EventEmitter, function(){
  });

  BlxPromise.prototype.then = function(){};

  BlxPromise.prototype.resolve = function(){};
  BlxPromise.prototype.reject = function(){};

});

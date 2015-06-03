;(function(){

  var BlxClass = function(){};

  BlxClass.prototype.extend = function extend(name, parent, constructor){

    eval('var child = function '+ name +'(){\
         if (this === window){ \
          return new arguments.callee();\
         }\
         this.parent = this.prototype;\
         constructor.apply(this, arguments);}');

         child.prototype = new parent();
         return child;
  };

  BlxClass.alias = function alias(name){
    eval('var aliasClosure = function '+name+'(){\
         return this[name].apply(this, arguments);\
         };');
    return aliasClosure;
  };

  window.BlxClass = new BlxClass();

})();

;(function(){

  var BlxClass = function BlxClass(){};

  BlxClass.prototype.extend = function extend(name, parent, constructor){

    var args = [];
    var args_l = constructor.__length__ || constructor.length;
    for(var i=0; i<args_l; i++){
      args.push('arguments['+ i +']');
    }

    var code = 'var child = function '+ name +'(){\
         if (!(this instanceof arguments.callee)){ \
          return new arguments.callee(' + args.join(', ') +');\
         }\
         this.__class__ = child;\
         constructor.apply(this, arguments);}';
    eval(code);

    child.__parent__ = parent;
    child.prototype = new parent();

    return child;
  };

  BlxClass.prototype.alias = function alias(name){
    var code = ('var aliasClosure = function '+name+'(){\
         return this[name].apply(this, arguments);\
         };');

    eval(code);
    return aliasClosure;
  };

  BlxClass.prototype.parent = function parent(_this, _class){

    var parent = _class.__parent__ || _class.prototype.constructor;
    if (typeof arguments[3] === 'string'){
      return parent.prototype[arguments[3]].apply(
        _this,
        arguments[3] || []
      );
    }
    else{
      return parent.apply(
        _this, 
        arguments[2] || []
      );
    }

  };

  window.BlxClass = new BlxClass();

})();

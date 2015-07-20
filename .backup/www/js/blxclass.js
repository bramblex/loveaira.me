;(function(){

  var attribute = function attribute(func){
    var i = this.init;
    this.init = function(){
      i.apply(this);
      func.apply(this);
    };
  };

  var method = function method(func){
    if(!func.name)
      throw 'Error: method must be named!';
    this.prototype[func.name] = func;
  }

  var BlxClass = function BlxClass(){};

  BlxClass.prototype.extend = function extend(name, parent, constructor){

    var args = [];
    var args_l = constructor.__length__ || constructor.length;
    for(var i=0; i<args_l; i++){
      args.push('arguments['+ i +']');
    }

    var code = 'var child = function '+ name +'(){\
         var this_func = arguments.callee;\
         if (!(this instanceof this_func)){ \
           return new arguments.callee(' + args.join(', ') +');\
         }\
         this_func.init.apply(this);\
         constructor.apply(this, arguments);\
         this.__class__ = child;\
         }';
    eval(code);

    child.__parent__ = parent;
    child.method = method;
    child.attribute = attribute;
    child.constructor = constructor;
    child.init = function(){
      if(!!child.parent && !!child.parent.init)
        child.parent.init.apply(this);
    };
    var proto = new parent();
    for (var i in proto){
      if(proto.hasOwnProperty(i))
        delete(proto[i]);
    }
    child.prototype = proto;
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

    var parent = _class.__parent__.constructor || _class.prototype.constructor;
    if (typeof arguments[2] === 'string'){
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

  BlxClass.prototype.destroy = function destroy(_this){
    for (var i in _this)
      delete(proto[i]);
  }

  window.BlxClass = new BlxClass();

})();


(function(){

  var BlxUtils = function(){};

  // An empty function.
  BlxUtils.prototype.emptyFunc = function(){};

  /*
   * function classExtend;
   * used to extend a class from anothor class.
   * @return: Class
   * @arguments: Class
   */

  BlxUtils.prototype.classExtend = function(ParentClass, constructionFunction){
    var _Class = function(){
      ParentClass.apply(this, arguments);
      constructionFunction.apply(this, arguments);
    }
    _Class.prototype = new ParentClass();
    _Class.prototype.parent = _Class.prototype;
    return _Class;
  };

  /*
   * function createInterface;
   * userd to create a factory function for a class and return a object;
   * @return: Class
   * @arguments: Object
   */
  BlxUtils.prototype.createInterface = function(Class){
    return function(){
      var _arguments = [];
      for (var i = 0, len = arguments.length; i < len; i++)
        _arguments.push(arguments[i]);
      eval('var result = new Class('+ _arguments.join(',') +');');
      return result;
    }
  };

  BlxUtils.prototype.displayAnimate = function(selector, css_class, callback){
    var item = $(selector);
    item.addClass(css_class);
    item.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
      item.removeClass(css_class);
      callback();
    });
  };


  var b_a = function(){
    this.count = this.count - 1
    if (this.count === 0)
      this.callback();
  };

  BlxUtils.prototype.barrier = function(c, cb){
    return {
      count: c,
      await: b_a,
      callback: cb,
    };
  };

  window.BlxUtils = new BlxUtils();
})();

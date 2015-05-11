
;(function(){
  'user script';
  var BlxClass = function(){
  };

  BlxClass.prototype.extend = function extend(parent, constructor){
    var child = function(){
      this.parent = this.prototype
      constructor.apply(this, constructor);
    };
    child.prototype = new parent();
    return child;
  };

  return new BlxClass();
});

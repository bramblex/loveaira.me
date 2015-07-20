
;(function(){

  var ViewModel = BlxClass.extend('ViewModel', EventEmitter, function(name){
    this.name = 'name';
  });

  ViewModel.prototype.binding = function binding(model){
  };

  ViewModel.prototype.render = function render(){
    this.view = View(this.name);
    View.render
  };

})();

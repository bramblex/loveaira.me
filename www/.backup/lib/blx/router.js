;(function(){

  var Router = BlxClass.extend('Router', EventEmitter, function(){
    this.defalut = 'main';
    this.history = [];
  });

  var parse = function parse(url){
    var pased = _.words(req, '\/');
    return {
      mv: parsed[0] || this.defalut,
      act: parsed[1] || this.index,
      args: parsed.slice(2),
    }; 
  };

  Router.prototype.back = function back(step){
    this.emit('change', url);
    var step = step || 1;
    return parse(this.history.pop());
  };


  Router.prototype.go = function(url){
    this.emit('change', url);
    this.history.push(url);
    return pasrse(url);
  };

  window.Router = new Router();
});

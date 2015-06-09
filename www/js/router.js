;(function(){
  var default_modelview = 'main';
  var default_action = 'index';

  var Router = Task(function(data, next){

    window.onhashchange = function(){
      window.onhashchange = null;
      var r = location.hash.split('/');
      var data = {
        vm: r[0] || default_modelview, 
        a: r[1] || default_modelview,
        args: r.slice(2) || []
      };
      next(data);
    };

  });

  window.Router = Router;
})();

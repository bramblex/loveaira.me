;(function(){
  var Distributor = Task(function(data, next){
    var vm = Task(ViewModels[data.vm][data.a]);
    vm.on('end', next);
    vm.start(data.args);
  });

  window.Distributor = Distributor;
})();

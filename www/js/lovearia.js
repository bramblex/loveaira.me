;(function(){

  var debug = Task(function(data, next){
  }); 

  var get = Task(function(url, next){
    $.get(url, function(_data){
      next(_data);
    });
  });


  var LoveAria = Task();
  //LoveAria.excute();
  window.LoveAria = LoveAria;

var a = Task(function(data, next){
  console.log('task1 start:', data);

  setTimeout(function(){
    console.log('task1 end:', data);
    next(data);
  }, 1000);

});

var b = Task(function(data, next){
  console.log('task2 start:', data);

  setTimeout(function(){
    console.log('task2 end:', data);
    next(data);
  }, 3000);

});

var c = Task(function(data, next){
  console.log('if true');
  next(data);
});

//c.excute(a);
//c.excute(b);

//a.on('end', function(data, step){
  //console.log(data, step);
//});

var s = Task();
s.on('next', function(data, step){console.log('next:', data, step, this.pc)});
s.on('start', function(data){console.log('start:', data)});
s.on('end', function(data, step){console.log('end:', data, step)});

s.excute(a);
s.branch( function(){return true;}, c);
s.excute(b);
s.start('data');


})();

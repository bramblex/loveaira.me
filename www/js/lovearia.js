//;(function(){

  ////============= 路  由 ==================
  //var Router = Task(function(data, next){
  //});

  ////============= 分配器 ==================
  //var Dispatcher = Task();
  //Dispatcher
    //.excute()
    //.excute()
    //.excute();

  ////============= 渲  染 ==================
  //var Render = Task();
  //Render
    //.excute()
    //.excute()
    //.excute();

  ////============= 主流程 ==================
  LoveAria = Task();
  //LoveAria
    //.excute(Router)
    //.excute(Dispatcher)
    //.excute(Render);

  //Task()
    //.excute(function(data, next){ next(localtion.hash); })
    //.loop(function(){return true}, LoveAria)
    //.start();
//})();

//;(function(){

  //var debug = Task(function(data, next){
  //}); 

  //var get = Task(function(url, next){
    //$.get(url, function(_data){
      //next(_data);
    //});
  //});


  //var LoveAria = Task();
  ////LoveAria.excute();
  //window.LoveAria = LoveAria;

//var a = Task(function(data, next){
  //console.log('task1 start:', data);

  //setTimeout(function(){
    //console.log('task1 end:', data);
    //next(data);
  //}, 1000);

//});

//var b = Task(function(data, next){
  //console.log('task2 start:', data);

  //setTimeout(function(){
    //console.log('task2 end:', data);
    //next(data);
  //}, 3000);

//});

//var c = Task(function(data, next){
  //console.log('if true');
  //next(data);
//});

////c.excute(a);
////c.excute(b);

////a.on('end', function(data, step){
  ////console.log(data, step);
////});

//var s = Task();
//s.on('next', function(data, step){console.log('next:', data, step, this.pc)});
//s.on('start', function(data){console.log('start:', data)});
//s.on('end', function(data, step){console.log('end:', data, step)});

//s.excute(a);
//s.branch( function(data){return true;}, c);
//s.excute(b);
//s.start('data');


//})();

//var delay_task_1 = Task(function(data, next){
  //consloe.log('delay_task_1');
  //setTimout(function(){
    //next(data);
  //}, 1000);
//});

//var delay_task_2 = Task(function(data, next){
  //consloe.log('delay_task_2');
  //setTimout(function(){
    //next(data);
  //}, 2000);
//});

//var task_sequence = Task();

//delay_task.on('end', function(data, step){
  //consloe.log(data);
//});

//delay_task.start('test');

//task_sequence.excute(delay_task);
//task_sequence.excute(function(data, next){
  //console.log('This is task 2');
  //next(data);
//});

////var task1 = Task();
//var exp = function(data){
  //return data
//};

//var t = Task(function(data, next){
  //console.log('is true');
//});

//var ts = Task();
//ts.branch(exp, t);

//var t1 = Task(function(data, next){
  //console.log('任务1 开始', '数据：' + data);

  //setTimeout(function(){
    //console.log('任务1 结束');
    //next('任务1返回的数据');
  //}, 1000);
//});

//var t2 = Task(function(data, next){
  //console.log('任务2 开始', '数据：' + data);

  //setTimeout(function(){
    //console.log('任务2 结束');
    //next('任务2返回的数据');
  //}, 1000);
//});

//var t3 = Task(function(data, next){
  //console.log('任务3 开始', '数据：' + data);

  //setTimeout(function(){
    //console.log('任务3 结束');
    //next('任务3返回的数据');
  //}, 1000);
//});

//ts.on('start',function(){console.log('任务序列执行开始')});
//ts.on('end',function(data){console.log('任务序列执行结束', '数据：' + data)});

//var ts = Task();
//ts.excute(t1)
  //.excute(t2)
  //.excute(t3)
  //.start();


  var t = 'a';
  var s = Task();
  s
    .loop(function(i){
      return i <= 100;
    },
      Task(function(i, next){
        setTimeout(function(){
          t = t + 't' + i;
          console.log(t);
          next(i+1);
        }, 0);
      })
      )
    .start(1);

var t = 'a';
var func = function(i, s){
  if (i > s)
    return;
  setTimeout(function(){
    t = t + 't' + i;
    console.log(t);
    func(i+1, s);
  }, 0);
};
//func(1, 3);

;(function(){

  var STOP = 0;
  var START = 1;

  var next = function next(data, step){

    this.emit('next');

    if (this.queue_length > 0 || this.pc >= this.queue_length){
      this.status = STOP;
      this.pc = 0;
      this.emit('end');
      return;
    };

    var _task = this.task_queue[this.pc];
    var _this = this;
    var _next = arguments.callee;

    _task(data, function(){
      _next.apply(_this, arguments);
    });

    this.pc = this.pc + (step || 1);
  };

  var BlxTask = BlxClass.extend('BlxTask', EventEmitter, function(task_queue){
    this.task_queue = task_queue || [];
    this.pc = 0,
    this.status = STOP;
  });

  BlxTask.prototype.start = function start(data){
    this.queue_length = this.task_queue.length;
    _this = this;

    setTimeout(function(){
      _this.emit('start');
      next.call(_this, data);
    }, 0);
  };

  BlxTask.prototype.fork = function fork(){
    return BlxTask(this.task_queue);
  };

  BlxTask.prototype.task = function excute(func){
    if (func instanceof Function)
      this.task_queue.push(func);
    return this;
  };

  BlxTask.prototype.barrier = function barrier(){
    var tasks = Array(arguments);

    this.task(function(data, next){
      var result = [];

      tasks.forEach(function(task){
        task(data, function(data){
          result.push(data || null);
          if (result.length === task.length)
            next(result);
        });
      });
    });

    return this;
  };

  BlxTask.prototype.subtask = function subtask(subtask){
    var subtask = subtask.fork();
    this.task(function(data, next){
      subtask.on('end', next);
      subtask.start(data);
    });
    return this;
  };

  BlxTask.prototype.branch = function branch(branch){
    var branch = branch.fork();
    this.task(function(data, next){
      branch.start(data);
      next();
    });
    return this;
  };

  window.BlxTask = BlxTask;

})();

//;(function(){
  //'user script';

  //var BlxProcess = BlxClass(Object, function(name){
    //this.parent.constructor();

    //this.__name__ = name;
    //this.__tasks__ = [];
    //this.__pos__ = 0;

    //this.__is_lock__ = false;
    //this.__is_fork__ = true;
    //this.__is_run__ = false;

    //// only use for subprocess
    //this.__on_end__ = function(){}; 
  //});

  //// Public
  //BlxProcess.prototype.excute = function(name, task){
    //if (!this.__is_lock__){
      //this.__tasks__.push({name: name, task: task});
      //return this
    //}
    //return false;
  //};

  //BlxProcess.prototype.run = function(){

    //if (!this.__is_fork__ && !this.__is_run__)
      //return false;

    //this.__is_run__ = true;

    //return this;
  //};

  //BlxProcess.prototype.stop = function(){
    //if (!this.__is_fork__ && !this.__is_run__)
      //return false;

    //this.__is_run__ = false;

    //return this;
  //};

  //BlxProcess.prototype.next = function(){
    //if (this.__pos__ >= this.__tasks__.length - 1){
      //this.__pos__ = 0;
      //this.stop();
      //this.apply(this.__on_end__, arguments);
      //return this;
    //}
    //else{
      //_this = this;
      //_task = this.__tasks__[this.__pos__]['task'];
      //_args = arguments;
      //setTimeout(function(){
        //try{
          //_this.apply(_task, args);
          //_this.__pos__ = _this.__pos__ + 1;
        //}
        //catch(err){
          //console.error('Process: '
                          //+ _this.__name__ 
                          //+ ', Task: '
                          //+ _task.name
                        //, err.message);
          //_this.stop();
        //}
      //}, 0);
    //}
  //};

  //BlxProcess.prototype.subprocess = function(name, proc){
    //return this.excute(name, function(){
      //_this = this;
      //proc.__on_end__ = function(){
        //_this.apply(_this.next, arguments);
      //};
      //proc.apply(proc.run, arguments);
    //});
  //};

  //BlxProcess.prototype.branch = function(name, proc){
    //return this.excute(name, function(){
      //proc.run();
    //});
  //};

  //BlxProcess.prototype.frok = function(){
    //var result = new this.constructor();
    //result.__isfork__ = false;
    //result.__lock__ = true;
    //return result;
  //};

  //BlxProcess.prototype._if = function(exp, subproc_true, subpoc_false){
    //return this.excute('if', function(){
    //});
  //};

  //BlxProcess.prototype._while = function(exp, subproc_true, subpoc_false){
    //return this.excute('while', function(){
    //});
  //};

  //window.BlxProcess = BlxProcess;
//})();

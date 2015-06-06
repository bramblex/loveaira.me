;(function(){

  var STOP = 0;
  var START = 1;

  //==================================================
  var BaseTask = BlxClass.extend('BaseTask', EventEmitter, function(){
    BlxClass.parent(this, BaseTask);
    this.status = STOP;
  });

  BaseTask.prototype.start = function start(data){
    this.status = START;

    this.emit('end', data, 1);
    this.start = STOP;
  };

  //=================================================
  var TaskUnit = BlxClass.extend('TaskUnit', BaseTask, function(func){
    BlxClass.parent(this, TaskUnit);
    if (typeof func !== 'function')
      throw 'Arguments type error';
    this.func = func;
  });

  TaskUnit.prototype.start = function start(data){
    if(this.status === START)
      throw 'Task is aready ran'
    this.status = START;

    var data = data;
    _this = this;

    setTimeout(function(){
      _this.emit('start', data);
      _this.func(data, function(_data, _step){
        var _data = _data;
        if (typeof _step !== 'number')
          var _step =  1;
        _this.emit('end', _data, _step);
        _this.status = STOP;
      });

    }, 0);
  };

  TaskUnit.prototype.fork = function fork(){
    return TaskUnit(this.func);
  };

  //=================================================
  var TaskSequence = BlxClass.extend('TaskSequence', BaseTask, function(){
    BlxClass.parent(this, TaskSequence);
    this.pc = 0;
    this.sequence = [];
  });

  var next = function next(_this, data, step){
    if (typeof step !== 'number')
      var step =  1;
    _next = arguments.callee;


    _this.pc = _this.pc + step;
    _this.emit('next', data, step);

    if (_this.pc < _this.sequeue_length){

      var current_task = _this.sequence[_this.pc];
      current_task.once('end', function(_data, _step){
        _next(_this, _data, _step);
      });
      current_task.start(data);

    }
    else{
        _this.pc = 0;
        _this.status = STOP;
        _this.emit('end', data, step);
    }

  };

  TaskSequence.prototype.start = function start(data){
    if (this.status === START)
      throw 'Task is aready ran'
    this.status = START;
    this.sequeue_length = this.sequence.length;
    var _this = this;
    setTimeout(function(){
      _this.emit('start', data);
      next(_this, data, 0);
    }, 0)
  };

  TaskSequence.prototype.excute = function excute(task){
    this.sequence.push(Task(task));
    return this;
  };

  TaskSequence.prototype.branch = function branch(condition, task){
    this.excute(function(data, next){
      if (!!condition(data))
        next(data);
      else
        next(data, 2);
    });
    this.excute(task);
  };

  TaskSequence.prototype.barrier = function barrier(){

    var args = Array.prototype.slice.call(arguments);
    this.excute(function(data, next){

      //var tasks = Array.prototype.slice.call(args);
      //var result = [];
      //if (tasks.length  === 0){
        //next(data);
        //return;
      //}

      //tasks.forEach(function(task){
        //var task = Task(task);
        //task.start(data)
        //task.once('end', function(data, step){
          //result.push(data);
          //if(result.length === tasks.length)
            //next(result);
        //});
      //});

    });
  };

  TaskSequence.prototype.fork = function fork(){
    var task_sequeue = TaskSequence();
    this.sequence.forEach(function(task){
      task_sequeue.excute(task);
    });
    return task_sequeue;
  };

  //=======================================================
  // Interface
  var Task = function Task(task){
    if (arguments.length === 0)
      return TaskSequence();
    else if(typeof task === 'function')
      return TaskUnit(task);
    else if(task instanceof BaseTask)
      return task.fork();
    else
      throw 'Arguments type error';
  };

  window.Task = Task;
})();

  //var BlxProcess = BlxClass.extend ('BlxProcess', BlxBaseTask, function(task_queue)){
    //this.parent.constructor.call(this);
    //this.task_queue = task_queue;
    //this.pc = 0; 
  //};

  //BlxProcess.prototype.start = function start(data){
    //var data = data | null;
    //var _this = this;

    //this.on('start', function(){
    //});

    //setTimeout(function(){
      //_this.emit('start', data);
      //_this.emit('next', data);
    //}, 0);
  //};

  //==================================================
  //var next = function next(data, step){

    //this.emit('next');

    //if (this.queue_length > 0 || this.pc >= this.queue_length){
      //this.status = STOP;
      //this.pc = 0;
      //this.emit('end');
      //return;
    //};

    //var _task = this.task_queue[this.pc];
    //var _this = this;
    //var _next = arguments.callee;

    //_task(data, function(){
      //_next.apply(_this, arguments);
    //});

    //this.pc = this.pc + (step || 1);
  //};

  //var BlxTask = BlxClass.extend('BlxTask', EventEmitter, function(task_queue){
    //this.task_queue = task_queue || [];
    //this.pc = 0,
    //this.status = STOP;
  //});
  ////==================================================

  //BlxTask.prototype.start = function start(data){
    //this.queue_length = this.task_queue.length;
    //_this = this;

    //setTimeout(function(){
      //_this.emit('start');
      //next.call(_this, data);
    //}, 0);
  //};

  //BlxTask.prototype.fork = function fork(){
    //return BlxTask(this.task_queue);
  //};

  //BlxTask.prototype.task = function excute(func){
    //if (func instanceof Function)
      //this.task_queue.push(func);
    //return this;
  //};

  //BlxTask.prototype.barrier = function barrier(){
    //var tasks = Array(arguments);

    //this.task(function(data, next){
      //var result = [];

      //tasks.forEach(function(task){
        //task(data, function(data){
          //result.push(data || null);
          //if (result.length === task.length)
            //next(result);
        //});
      //});
    //});

    //return this;
  //};

  //BlxTask.prototype.subtask = function subtask(subtask){
    //var subtask = subtask.fork();
    //this.task(function(data, next){
      //subtask.on('end', next);
      //subtask.start(data);
    //});
    //return this;
  //};

  //BlxTask.prototype.branch = function branch(condition, branch){

    ////var branch = branch.fork();
    ////this.task(function(data, next){
      ////branch.start(data);
      ////next();
    ////});
    ////var branch
    
    //return this;
  //};

  //window.BlxTask = BlxTask;

//})();

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

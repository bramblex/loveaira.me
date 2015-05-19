
;(function(){
  'user script';

  var BlxProcess = BlxClass(Object, function(name){
    this.parent.constructor();

    this.__name__ = name;
    this.__tasks__ = [];
    this.__pos__ = 0;

    this.__is_lock__ = false;
    this.__is_fork__ = true;
    this.__is_run__ = false;

    // only use for subprocess
    this.__on_end__ = function(){}; 
  });

  // Public
  BlxProcess.prototype.excute = function(name, task){
    if (!this.__is_lock__){
      this.__tasks__.push({name: name, task: task});
      return this
    }
    return false;
  };

  BlxProcess.prototype.run = function(){

    if (!this.__is_fork__ && !this.__is_run__)
      return false;

    this.__is_run__ = true;

    return this;
  };

  BlxProcess.prototype.stop = function(){
    if (!this.__is_fork__ && !this.__is_run__)
      return false;

    this.__is_run__ = false;

    return this;
  };

  BlxProcess.prototype.next = function(){
    if (this.__pos__ >= this.__tasks__.length - 1){
      this.__pos__ = 0;
      this.stop();
      this.apply(this.__on_end__, arguments);
      return this;
    }
    else{
      _this = this;
      _task = this.__tasks__[this.__pos__]['task'];
      _args = arguments;
      setTimeout(function(){
        try{
          _this.apply(_task, args);
          _this.__pos__ = _this.__pos__ + 1;
        }
        catch(err){
          console.error('Process: '
                          + _this.__name__ 
                          + ', Task: '
                          + _task.name
                        , err.message);
          _this.stop();
        }
      }, 0);
    }
  };

  BlxProcess.prototype.subprocess = function(name, proc){
    return this.excute(name, function(){
      _this = this;
      proc.__on_end__ = function(){
        _this.apply(_this.next, arguments);
      };
      proc.apply(proc.run, arguments);
    });
  };

  BlxProcess.prototype.branch = function(name, proc){
    return this.excute(name, function(){
      proc.run();
    });
  };

  BlxProcess.prototype.frok = function(){
    var result = new this.constructor();
    result.__isfork__ = false;
    result.__lock__ = true;
    return result;
  };

  BlxProcess.prototype._if = function(exp, subproc_true, subpoc_false){
    return this.excute('if', function(){
    });
  };

  BlxProcess.prototype._while = function(exp, subproc_true, subpoc_false){
    return this.excute('while', function(){
    });
  };

  window.BlxProcess = BlxProcess;
})();

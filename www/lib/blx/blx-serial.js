
(function(){

  //var classExtend = BlxUtils().classExtend();
  //var createInterface = BlxUtils().create
  utils = BlxUtils;

  /*
   * Define Base Class
   *
   */
  var BlxBaseSerial = utils.classExtend(Object, function(){
    this._task_list = [];
    this._current_point = 0;
    this._on_end = utils.emptyFunc;
  });

  BlxBaseSerial.prototype.excute = function(func){
    this._task_list.push(func);
    return this;
  };

  BlxBaseSerial.prototype.end = function(func){
    this._on_end = func;
    return this;
  };

  BlxBaseSerial.prototype.next = function(data){
    var _this = this;
    var next = function(d){_this.next(d)};
    if (this._current_point < this._task_list.length){
      var current_task = this._task_list[this._current_point];
      this._current_point = this._current_point + 1;
      setTimeout(function(){
        current_task(next, data);
      },0);
    }
    else{
      this._current_point = 0;
      this._on_end(data);
    }
  };

  BlxBaseSerial.prototype.run = function(data){
    this.next(data);
    return this;
  };

  /*
  *  Define Class BlxTask extend from Class BlxBaseSerial
  */

  var BlxTask = utils.classExtend(BlxBaseSerial, function(){});

  BlxTask.prototype.branch = function(task){
    return this.excute(function(next, data){
      task.run(data);
      next(data);
    });
  };

  BlxTask.prototype.subTask = function(task){
    return this.excute(function(next, data){
      task.end(function(_data){
        next(_data);
        return this;
      });
      task.run(data);
    });
  }

  BlxTask.prototype.animate = function(option){
    return this.excute(function(next, data){
      if(typeof option === 'undefined'){
        var option = data.option;
      }
      var count = Object.getOwnPropertyNames(option).length;
      var barrier = utils.barrier(count, function(){next();});

      for (selector in option){
        utils.displayAnimate(selector,
            ['animated',option['selector']].join(' '),
            function(){barrier.await()});
      }

    });
  }

  BlxTask.prototype.get = function(url){
    return this.excute(function(next, data){
      if(typeof url === 'undefined'){
        var url = data.url;
      }
      $.get(data, function(result){
        next(result);
      });
    });
  }

  BlxTask.prototype.post = function(url, froms){
    return this.excute(function(next, data){
      if(typeof url === 'undefined' || typeof froms === 'undefined'){
        var url = data.url;
        var froms = data.froms;
      }
      $.post(url, froms,function(result){
        next(result);
      });
    });
  }

  window.BlxTask = utils.createInterface(BlxTask);
})();

(function(){

  var n = null;
  var GameMap = BlxClass.extend('GameMap', Object, function(){
    this.map = [
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
      [n, n, n, n, n, n, n, n, n, n, n, n, n],
    ];
  });

  GameMap.prototype.get = function get(x, y){
    return this.map[x][y];
  };

  GameMap.prototype.set = function set(x, y, obj){
    if(x>12)
      return this.set(12, y, obj);
    if(x<0)
      return this.set(0, y, obj);
    if(y>12)
      return this.set(x, 12, obj);
    if(y<0)
      return this.set(x, 0, obj);

    if (obj && obj.pos)
      throw 'Error: Ojbect is already in map!'
    this.map[x][y] = obj;
    if(!!obj){
      obj.pos = {x:x,y:y};
      $('#'+x+'-'+y).html(obj.content);
    }
    else
      $('#'+x+'-'+y).html('');
    return obj;
  };

  GameMap.prototype.remove = function remove(x, y){
    var obj = this.get(x, y);
    this.set(x, y, n);
    if(obj)
      obj.pos = null;
    return obj;
  };

  GameMap.prototype.move = function move(x1, y1, x2, y2 ){
    return this.set(x2, y2, this.remove(x1, y1));
  }

  window.GameMap = GameMap();

  var Spirit = BlxClass.extend('Spirit', FSM, function(content){
    BlxClass.parent(this, Spirit);
    this.map = null;
    this.content = content;
  });

  Spirit.prototype.binding = function binding(map){
    this.map = map;
    return this;
  }

  Spirit.prototype.set = function set(x,y){
    this.map.set(x,y,this);
    return this;
  };

  Spirit.prototype.move = function move(x,y){
    if (this.pos && this.map.get(this.pos.x,this.pos.y) === this)
      this.map.move(this.pos.x, this.pos.y, x, y);
    else
      throw 'Error: Can not move';
  }

  window.tank = Spirit('<a style="color: #FFF"> _[|]_<br/>###</a>');
  tank.binding(window.GameMap).set(1,1);
  tank.left = function left(){
    this.move(this.pos.x, this.pos.y-1);
  };
  tank.right = function right(){
    this.move(this.pos.x, this.pos.y+1);
  };
  tank.up = function up(){
    this.move(this.pos.x-1, this.pos.y);
  };
  tank.down = function down(){
    this.move(this.pos.x+1, this.pos.y);
  };

  $(window).keydown(function(event){  

    switch (event.keyCode) {
      case 38:
        tank.up();
        break;
      case 40:
        tank.down();
        break;
      case 37:
        tank.left();
        break;
      case 39:
        tank.right();
        break;
    }
    
    //alert(event.keyCode);                       
  }); 

})();

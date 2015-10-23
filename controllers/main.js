
module.exports = Controller.extend('main')

.method('index', function(){
  this.response.write('index');
  this.response.end();
})

.method('show', function(){
  this.response.write(JSON.stringify(this.parsed));
  this.response.end();
})

.method('show', function(t1, t2){
  this.response.write('show');
  this.response.write(t1);
  this.response.write(t2);
  this.response.end();
})

.method('steal', function(username, password){
  console.log(username, password);
  this.response.end();
})
;

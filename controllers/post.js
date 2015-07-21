
module.exports = Controller.extend('post')

.method('index', function(){
  this.response.write('post index');
  this.response.end();
})
;

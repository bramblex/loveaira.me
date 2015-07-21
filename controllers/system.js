
var process = require('child_process');

module.exports = Controller.extend('system')

.method('update', function(){
  var _this = this;
  process.exec('git pull origin master',function(err, stdout, stderr){
    _this.response.end(stdout + stderr);
  });
})

.method('reload', function(){
  this.response.end('system reload!');
  throw 'system reload!';
});

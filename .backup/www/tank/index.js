;(function(){


  var libs = [
    'lib/zepto.js',
    'lib/lodash.js',
    'lib/blxclass.js',
    'lib/eventemitter.js',
    'lib/fsm.js',
    'js/game.js',
    'js/app.js',
  ];

  var onProgress = function onProgress(a, b, c){
      console.log(parseInt((b / c) * 100).toString() + '%', a);
    };

  var onReady = function(){
    app.start();
  };

  LoadScript(libs, onReady, onProgress);

})();


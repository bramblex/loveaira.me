;(function(){


  var libs = [
    'js/zepto.js',
    'js/lodash.js',
    'js/blxclass.js',
    'js/eventemitter.js',
    'js/blxtask.js',
    'js/lovearia.js',
  ];

  var onProgress = (function(){

    var bar = document.getElementById('loading_progress_bar');
    var message = document.getElementById('loading_message');

    return function onProgress(a, b, c){
      bar.style.width = ((b / c) * 100).toString() + '%';
      message.innerHTML = ['loading', '(', b, '/', c, ')'].join('');
    };

  })();

  var onReady = function(){
    $('#loading_page').fadeOut();
    $('#layout').removeClass('hidden');
    //var LoveAria = {start: function(){console.log('LoveAria start!');}};
    //LoveAria.start();
  };

  LoadScript(libs, onReady, onProgress);

})();


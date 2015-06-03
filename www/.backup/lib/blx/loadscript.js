;(function(){

  var LoadScript = function LoadScript(urls, callback) {
    if (typeof urls === 'string') {
      var urls = [
        urls
      ];
    }
    if (!Array.isArray(urls)) {
      throw 'argument type error';
    }
    if (urls.length <= 0) {
      callback();
      return;
    }
    var head = document.head;
    var _LoadScript = arguments.callee;
    var script = document.createElement('script');
    script.src = urls[0];
    script.className = 'loadscript';
    script.async = false;
    script.type = 'text/javascript'
    script.charset = 'utf-8'
    head.insertBefore(script, head.firstChild);
    script.onload = script.onerror = function () {
      script.onload = script.onerror = null;
      _LoadScript(urls.slice(1), callback);
    };
  };

  window.LoadScript = LoadScript;

})();

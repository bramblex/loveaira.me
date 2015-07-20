;(function(){
  var Render = Task();

  Render
    .excute(getTemplate)
    .excute(renderTemplate)
    .excute(dataBingding);

  window.Render = Render;
})();

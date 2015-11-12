var cps = (function(){

  var Environment = Class('Environment', Array)

  var transform = function transform(node){
    estraverse.traverse(node, {
      enter: function(node, parent){
        console.log(node.type, 'enter');
        return node;
      },
      leave: function(node, parent){
        console.log(node.type, 'leave');
        return node;
      },
    });
    return node;
  };

  return {
    transform : transform
  };

})();

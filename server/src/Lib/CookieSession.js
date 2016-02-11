"use strict";
// module Lib.CookieSession

exports.cookieSession = require('cookie-session');

exports._sessionSet = function(req, key, value){
    return function(){
        req.session[key] = value;
    };
};

exports._sessionGet = function(req, key){
    return function(){
        return req.session[key] || {};
    };
};

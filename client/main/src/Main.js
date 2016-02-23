"use strict";
// module Main

exports.confirm = function(info){
    return function(){
        return confirm(info);
    };
};

exports.refresh = function(){
    location.href = location.href.replace(/#.*$/, '');
};

exports.redirect = function(url){
    return function(){
        location.href = url;
    };
};

exports.alert = function(info){
    return function(){
        return alert(info);
    };
};

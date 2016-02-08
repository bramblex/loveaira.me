"use strict";
// module Main

exports.bodyParser = require('body-parser').urlencoded({ extended: false });
exports.staticSever = require('express').static;

exports.__setTimeout = function(n, error, success){
        return function(){
            setTimeout(function(){success(n)();}, n);
        };
};

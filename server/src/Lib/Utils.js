"use strict";
// module Lib.Utils
var crypto = require('crypto');

exports.__filename = function(){
    return __filename;
};

exports.__dirname = function(){
    return __dirname;
};

exports.sha1 = function(secret){
    return function(str){
        return crypto.createHmac('sha1', secret).update(str).digest('hex');
    };
};

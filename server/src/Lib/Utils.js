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

exports.__toplevel = function(){
    return require('child_process').execSync('git rev-parse --show-toplevel').toString('utf8').replace(/\n$/, '');
};

exports.encodeURIComponent = encodeURIComponent;
exports.encodeURI = encodeURI;
exports.decodeURIComponent = decodeURIComponent;
exports.decodeURI = decodeURI;

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

exports.escapeString = function(str){
    return "'" + str.replace(/'/g, '\'\'') + "'";
};

exports.randString = function randString(x){
    return function(){
        var s = "";
        while(s.length<x&&x>0){
            var r = Math.random();
            s+= (r<0.1?Math.floor(r*100):String.fromCharCode(Math.floor(r*26) + (r>0.5?97:65)));
        }
        return s;
    };
};

// exports.escapeString = function(str){
//     return "'" + str.replace(/[\0\x08\x09\x1a\n\r"'\\\%]/g, function (char) {
//         switch (char) {
//             case "\0":
//                 return "\\0";
//             case "\x08":
//                 return "\\b";
//             case "\x09":
//                 return "\\t";
//             case "\x1a":
//                 return "\\z";
//             case "\n":
//                 return "\\n";
//             case "\r":
//                 return "\\r";
//             case "\"":
//             case "'":
//             case "\\":
//             case "%":
//                 return "\\"+char; // prepends a backslash to backslash, percent,
//                                   // and double/single quotes
//         }
//         return "";
//     }) + "'";
// };

exports.encodeURIComponent = encodeURIComponent;
exports.encodeURI = encodeURI;
exports.decodeURIComponent = decodeURIComponent;
exports.decodeURI = decodeURI;

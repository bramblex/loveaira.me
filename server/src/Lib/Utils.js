"use strict";
// module Lib.Utils

exports.__filename = function(){
    return __filename;
};

exports.__dirname = function(){
    return __dirname;
};

(function(){
    var crypto = require('crypto');
    exports.sha1 = function(secret){
        return function(str){
            return crypto.createHmac('sha1', secret).update(str).digest('hex');
        };
    };
})();


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

exports.mdToHtml = function (md){
    return require('markdown').parse(md);
};

exports.merge = function (a){
    return function(b){
        var r = {};
        keys(a).forEach(function(key){
            r[key] = a[key];
        });
        keys(b).forEach(function(key){
            r[key] = b[key];
        });
        return r;
    };
};

exports.repeat = function(n){
    return function(str){
        return Array(n+1).join(str);
    };
};

exports.encodeURIComponent = encodeURIComponent;
exports.encodeURI = encodeURI;
exports.decodeURIComponent = decodeURIComponent;
exports.decodeURI = decodeURI;

var keys = (function() {
    'use strict';
    var hasOwnProperty = Object.prototype.hasOwnProperty,
        hasDontEnumBug = !({ toString: null }).propertyIsEnumerable('toString'),
        dontEnums = [
            'toString',
            'toLocaleString',
            'valueOf',
            'hasOwnProperty',
            'isPrototypeOf',
            'propertyIsEnumerable',
            'constructor'
        ],
        dontEnumsLength = dontEnums.length;

    return function(obj) {
        if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
            throw new TypeError('Object.keys called on non-object');
        }

        var result = [], prop, i;

        for (prop in obj) {
            if (hasOwnProperty.call(obj, prop)) {
                result.push(prop);
            }
        }

        if (hasDontEnumBug) {
            for (i = 0; i < dontEnumsLength; i++) {
                if (hasOwnProperty.call(obj, dontEnums[i])) {
                    result.push(dontEnums[i]);
                }
            }
        }
        return result;
    };
}());

exports._require = function(path){
    return require(path);
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

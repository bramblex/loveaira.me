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

exports.runcmd = function(cmd){
    return function(){
        return require('child_process').execSync(cmd).toString('utf8');
    };
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

(function(){
    var marked = require('marked');
    var highlightjs = require('highlight.js');
    marked.setOptions({
        highlight: function(code, lang){
            var langLowerCase = lang && lang.toLowerCase();
            if (!!lang && !!highlightjs.getLanguage(langLowerCase)){
                return highlightjs.highlight(langLowerCase, code).value;}
            else{return highlightjs.highlightAuto(code).value;}
        },
        breaks: true
    });

    var toc = {
        __content__: [],
        clean: function(){
            this.__content__ = [];
        },
        add: function(text, level, href){
            this.__content__.push({text: text, level: level, href: href});
        },
        render: function(){
            if (this.__content__.length <= 0){
              return '';
            }
            var tmp = this.__content__.map(function(heading){
                return {
                    level: heading.level,
                    content: '<li><a href="#' + heading.href +'">' + heading.text + '</a></li>'
                };
            });

            var result = "";
            var last_stack = [0];

            for (var i=0; i<tmp.length; i++){
                var h = tmp[i];
                var last = last_stack.unshift();
                if (h.level === last){
                    result += h.content;
                }
                else if (h.level > last){
                    last_stack.push(h.level);
                    result += "<ul>";
                    result += h.content;
                }
                else if (h.level < last){
                    last_stack.pop();
                    result += "</ul>";
                    i -= 1;
                    continue;
                }
            }

            return '<h2>目录</h2>'+ result + last_stack.map(function(){return '</ul>';}).join('');
        }
    };

    var renderer = new marked.Renderer();
    renderer.heading = function(text, level){
        var escapedText = text.replace(/[^a-zA-Z0-9\u4e00-\u9fa5_]+/g, '-');
        toc.add(text, level, escapedText);
        return '<h' + level + '><a name="' +
            escapedText +
            '" class="anchor" href="#' +
            escapedText +
            '"><span class="header-link">▶</span></a>' +
            text + '</h' + level + '>';
    };

    exports.mdToHtml = function (md){
        toc.clean();
        var doc = marked(md, {renderer: renderer});
        return toc.render() + doc;
    };
})();

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

exports.reomveArgsFromPath = function(path){
    return path.replace(/\?.*$/, '');
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

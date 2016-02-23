"use strict";
// module Lib.Cache


var cache = {};
var now = function(){return parseInt(Date.now() /1000);};

exports._cache = function(expired_time, key, val){
    // console.log("cache", key);
    return function(){
        cache[key] = {val: val, expired_at: now() + expired_time};
    };
};
exports._getCached = function(key){
    return function(){
        var r = cache[key];
        if (!r) {return null;};
        if (now() > r.expired_at) {cache[key] = null;}
        return r.val;
    };
};
exports._cleanCached = function(){
    return function(){
        cache = {};
    };
};

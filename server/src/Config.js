"use strict";
//module Config
exports._getSecurityKey = function(path){
    var top_level = require('child_process').execSync('git rev-parse --show-toplevel').toString('utf8').replace(/\n$/, '');
    return require(top_level + '/website/' + path);
};

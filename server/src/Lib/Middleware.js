"use strict";
//module Lib.Middleware

exports.bodyParser = require('body-parser').urlencoded;
exports['static'] = require('express')['static'];

exports.setCookiesMaxAge = function(maxAge){
    return function(req, res, next){
        req.sessionOptions.maxAge = maxAge * 1000;
        next();
    };
};

(function(){

    var sha1 = function(secret, str){
        return require('crypto').createHmac('sha1', secret).update(str).digest('hex');
    };

    exports._githubWebhockHandler = function(secret){
        return function(req, res, next){
            return function(){
                var data = ""; req.on('data', function(t){data += t;});

                req.on('end', function(){
                    if (sha1(secret, data) === req.get('X-Hub-Signature')){
                        next();
                    }
                    else{
                        res.sendStatus(403);
                        res.end();
                    };
                    // var result = JSON.parse(data);
                    // require('child_process').exec('git pull && npm install');
                    // res.end(data);
                });
            };
        };
    };

})();



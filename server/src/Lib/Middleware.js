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

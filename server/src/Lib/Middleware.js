"use strict";
//module Lib.Middleware

exports.bodyParser = require('body-parser').urlencoded;
exports['static'] = require('express')['static'];

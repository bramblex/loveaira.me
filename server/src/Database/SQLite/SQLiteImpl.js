"use strict";
// module Database.SQLite.SQLiteImpl
var makeBinding = function makeBinding(origin, method, args, result){
    var _result;
    if (result === undefined) { _result = '(result)'; }
    else if (result === null) { _result = '()'; }
    else { _result = '('+result+')'; }

    var r = ('\n\
             (function('+[origin].concat(args).join(', ')+', onFailure, onSuccess){\n\
                   return function(){\n\
                     try{console.log("SQL:", sql);}catch(e){};\n\
                     var _return = '+origin+'.'+method+'('+args.map(function(a){return a+', ';}).join('')+'function(error, result){\n\
                       if (error) { onFailure(error)(); }\n' + (result !== null ? '\
                       else if (!'+_result+') { onFailure(new Error("Not Found"))(); }\n' : '') + '\
                       else { onSuccess'+_result+'(); }\n\
                     });\n\
                   };\n\
                 })');
    return eval(r);
};

var sqlite3 = require('sqlite3');

exports.connectDBImpl = function(path, mode, onFailure, onSuccess){
    return function(){
        var db = new sqlite3.cached.Database(path, mode, function(err){
            if (err){onFailure(err)();}
            else{onSuccess(db)();}
        });
    };
};

exports.closeDBImpl = makeBinding('db', 'close', [], null);

exports.runDBImpl = makeBinding('db', 'run', ['sql'], null);
exports.runDB1Impl = makeBinding('db', 'run', ['sql', 'params_list'], null);
exports.runDB2Impl = makeBinding('db', 'run', ['sql', 'params_map'], null);

exports.getDBImpl = makeBinding('db', 'get', ['sql']);
exports.getDB1I1mpl = makeBinding('db', 'get', ['sql', 'params_list']);
exports.getDB2Impl = makeBinding('db', 'get', ['sql', 'params_map']);

exports.allDBImpl = makeBinding('db', 'all', ['sql']);
exports.allDB1Impl = makeBinding('db', 'all', ['sql', 'params_list']);
exports.allDB2Impl = makeBinding('db', 'all', ['sql', 'params_map']);

exports.eachDBImpl = makeBinding('db', 'each', ['sql', 'callback']);
exports.eachDB1Impl = makeBinding('db', 'each', ['sql', 'params_list', 'callback']);
exports.eachDB2Impl = makeBinding('db', 'each', ['sql', 'params_map', 'callback']);

exports.execDBImpl = makeBinding('db', 'exec', ['sql'], null);
exports.execDB1Impl = makeBinding('db', 'exec', ['sql', 'params_list'], null);
exports.execDB2Impl = makeBinding('db', 'exec', ['sql', 'params_map'], null);

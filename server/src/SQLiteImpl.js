"use strict";
// module SQLiteImpl
var makeBinding = function makeBinding(origin, method, args, result){
    var _result;
    if (result === undefined) { _result = ''; }
    else if (result === null) { _result = '()'; }
    else { _result = '('+result+')'; }
    return eval('(function('+[origin].concat(args).join(', ')+', onSuccess, onFailure){\
                   return function(){\
                     var _return = '+origin+'.'+method+'('+[origin].concat(args).join(', ')+', function(error, result){\
                       if (error) { onFailure(error)(); }\
                       else { onSuccess'+_result+'(); }\
                     });\
                   };\
                 })');
};

var sqlite3 = require('sqlite3');

exports.memory_db = ":memory:";

exports.open_readonly_mode = sqlite3.OPEN_READONLY;
exports.open_readwrite_mode = sqlite3.OPEN_READWRITE;
exports.open_create_mode = sqlite3.OPEN_CREATE;
exports.default_mode = sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE;

exports.connectDBImpl = function(path, mode, onSuccess, onFailure){
    return function(){
        var db = new sqlite3.Database(path, mode, function(err){
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

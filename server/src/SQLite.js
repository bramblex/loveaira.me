"use strict";
// module SQLite
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

exports.runFromDBImpl = makeBinding('db', 'run', ['sql'], null);
exports.runFromDB1Impl = makeBinding('db', 'run', ['sql', 'params_list'], null);
exports.runFromDB2Impl = makeBinding('db', 'run', ['sql', 'params_map'], null);

exports.getFromDBImpl = makeBinding('db', 'get', ['sql']);
exports.getFromDB1I1mpl = makeBinding('db', 'get', ['sql', 'params_list']);
exports.getFromDB2Impl = makeBinding('db', 'get', ['sql', 'params_map']);

exports.allFromDBImpl = makeBinding('db', 'all', ['sql']);
exports.allFromDB1Impl = makeBinding('db', 'all', ['sql', 'params_list']);
exports.allFromDB2Impl = makeBinding('db', 'all', ['sql', 'params_map']);

exports.eachFromDBImpl = makeBinding('db', 'each', ['sql', 'callback']);
exports.eachFromDB1Impl = makeBinding('db', 'each', ['sql', 'params_list', 'callback']);
exports.eachFromDB2Impl = makeBinding('db', 'each', ['sql', 'params_map', 'callback']);

exports.execFromDBImpl = makeBinding('db', 'exec', ['sql'], null);
exports.execFromDB1Impl = makeBinding('db', 'exec', ['sql', 'params_list'], null);
exports.execFromDB2Impl = makeBinding('db', 'exec', ['sql', 'params_map'], null);

// === Statment ===
exports.prepareDBImpl = makeBinding('db', 'prepare', ['sql'], '_return');
exports.prepareDB1Impl = makeBinding('db', 'prepare', ['sql', 'params_list'], '_return');
exports.prepareDB2Impl = makeBinding('db', 'prepare', ['sql', 'params_map'], '_return');

exports.bindStmtImpl = makeBinding('stmt', 'bind', [], null);
exports.bindStmt1Impl = makeBinding('stmt', 'bind', ['params_list'], null);
exports.bindStmt2Impl = makeBinding('stmt', 'bind', ['params_map'], null);

exports.resetStmtImpl = makeBinding('stmt', 'reset', [], null);

exports.finalizeStmtImpl = makeBinding('stmt', 'finalize', [], null);

exports.runStmtImpl = makeBinding('stmt', 'run', [], null);
exports.runStmt1Impl = makeBinding('stmt', 'run', ['params_list'], null);
exports.runStmt2Impl = makeBinding('stmt', 'run', ['params_map'], null);

exports.getStmtImpl = makeBinding('stmt', 'get', []);
exports.getStmt1I1mpl = makeBinding('stmt', 'get', ['params_list']);
exports.getStmt2Impl = makeBinding('stmt', 'get', ['params_map']);

exports.allStmtImpl = makeBinding('stmt', 'all', []);
exports.allStmt1Impl = makeBinding('stmt', 'all', ['params_list']);
exports.allStmt2Impl = makeBinding('stmt', 'all', ['params_map']);

exports.eachStmtImpl = makeBinding('stmt', 'each', ['callback']);
exports.eachStmt1Impl = makeBinding('stmt', 'each', ['params_list', 'callback']);
exports.eachStmt2Impl = makeBinding('stmt', 'each', ['params_map', 'callback']);

exports.execStmtImpl = makeBinding('stmt', 'exec', [], null);
exports.execStmt1Impl = makeBinding('stmt', 'exec', ['params_list'], null);
exports.execStmt2Impl = makeBinding('stmt', 'exec', ['params_map'], null);

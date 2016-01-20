"use strict"
// module SQLite3
var connect = function connect(filepath, onSuccess, onFailure){
  var db = new require('sqlite3').Database(filepath, function(err){
    if (err)
      onFailure(err.code);
    else
      onSuccess(db);
  });
};

var close = function close(db, onSuccess, onFailure){
  db.close(function(err){
    if (err)
      onFailure(err.code);
    else
      onSuccess();
  });
}

var run = function run(db, sql, onSuccess, onFailure){
  db.run(sql, function(err){
    if (err)
      onFailure(err.code);
    else
      onSuccess();
  });
}

var get = function get(db, sql, onSuccess, onFailure){
  db.get(sql, function(err, row){
    if (err)
      onFailure(err.code);
    else
      onSuccess(row);
  });
}

var all = function all(db, sql, onSuccess, onFailure){
  db.all(sql, function(err, rows){
    if (err)
      onFailure(err.code);
    else
      onSuccess(rows);
  });
}

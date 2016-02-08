"use strict";
// module Database.SQLite.Type

var sqlite3 = require('sqlite3');

exports.memory_db = ":memory:";

exports.open_readonly_mode = sqlite3.OPEN_READONLY;
exports.open_readwrite_mode = sqlite3.OPEN_READWRITE;
exports.open_create_mode = sqlite3.OPEN_CREATE;
exports.default_mode = sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE;

var sqlite3 = require('sqlite3');

var db = new sqlite3.cached.Database("/tmp/test.db", function(err){
    // db.run("insert into Test(info) values('aaa')");
    db.get("select * from Test", function(err, row){
        console.log(row);
    });
});

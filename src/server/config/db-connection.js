// Creating connection pool for mysql server
// Limiting the maximum number of connections to 10

var mysql = require('mysql');

function Connection() {
    this.pool = null;
    this.init = function () {
        this.pool = mysql.createPool({
            connectionLimit: 10,
            host: 'localhost',
            user: 'root',
            password: '1234',
            database: 'wta'
        });
    };

    this.acquire = function (res) {
        this.pool.getConnection(function (err, connection) {
            res(err, connection);
        });
    };
}

module.exports = new Connection();

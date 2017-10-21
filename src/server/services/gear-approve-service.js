var connection = require('../config/db-connection');

function Request() {

    // Getting list of requests with status as "requested" and "approved"
    this.get = function (id, res) {
        connection.acquire(function (err, con) {
            con.query('CALL get_requests()', function (err, result) {
                con.release();
                if(err) {
                    console.log(err);
                    throw err;
                } else {
                    res.send(result);
                }
            });
        });
    };

    // Approving the gear request
    this.post = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL approve_request('+req.query.requestId+')', req, function (err, result) {
                con.release();    
                if (err) {
                    console.log(err);
                    res.send(false);
                    throw err;
                } else {
                    res.send(true);
                }
            });    
        });
    };

}

module.exports = new Request();
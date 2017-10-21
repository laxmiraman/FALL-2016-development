var connection = require('../config/db-connection');

function Request() {

    // Getting list of requests with status as "requested" and "approved"
    this.get = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL get_user_gear_requests(\'' + req.query.userId + '\')', function (err, result) {
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

}

module.exports = new Request();
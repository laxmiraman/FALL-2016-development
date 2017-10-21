var connection = require('../config/db-connection');

function Request() {


    // Getting request details
    // pre: request params are the id of the gear request to get details for
    // post: gear request details are returned or error is logged
    this.get = function (id, res) {
        connection.acquire(function (err, con) {
            con.query('CALL GetMoreGearDetails('+id+')', function (err, result) {
                con.release();
                if(err) {
                    console.log(err);
                    throw err;
                } else {
                    res.send(result);
                }
            });
        });
    }
}

module.exports = new Request();
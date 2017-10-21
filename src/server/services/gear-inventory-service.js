var connection = require('../config/db-connection');


function Request() {

    this.get = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL Get_Gear_Inventory()', req, function (err, result) {
                con.release();
                if (err) {
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
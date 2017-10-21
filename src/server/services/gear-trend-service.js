var connection = require('../config/db-connection');
var moment = require('moment');

function Gear() {

    this.get = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL gear_request_trend(\'' + req.query.trendYear + '\')', req, function (err, result) {
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

module.exports = new Gear();
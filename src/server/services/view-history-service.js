var connection = require('../config/db-connection');


function Request() {

    this.viewByTripLeader = function (req, res) {
        connection.acquire(function (err, con) {
            //con.query('CALL RequestHisotryByTripLeader(\'' + req.query.startdate + '\',\'' + req.query.enddate + '\')', req, function (err, result) {
            con.query('CALL RequestHistoryByTripLeader(\'' + req.query.name + '\');', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    console.log(result);
                    res.send(result);
                }
            });
        });
    };

    this.viewByDate = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL RequestHistoryByDate(\'' + req.query.startdate + '\',\'' + req.query.enddate + '\')', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    console.log(result);
                    res.send(result);
                }
            });
        });
    };

}

module.exports = new Request();
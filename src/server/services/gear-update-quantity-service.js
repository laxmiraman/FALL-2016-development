var connection = require('../config/db-connection');

function Update() {

    this.post = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL update_gear_inventory(\'' + req.gearid + '\',\'' + req.gearquantity + '\');', req, function (err, result) {
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

module.exports = new Update();
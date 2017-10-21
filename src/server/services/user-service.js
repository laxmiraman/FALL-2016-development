var connection = require('../config/db-connection');

function User() {

    // Getting a user
    // pre: request param is the user email
    // post: user data is returned or an empty object
    this.getUserByEmail = function (req, res) {
        connection.acquire(function (err, con) {
            console.log("QUERY is: "+req.query);
            con.query('CALL getUserInfoByEmail(\''+req.query.email+'\')', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    console.log("SUCCESS");
                    console.log(result);
                    res.send(result);
                }
            });
        });
    };

    // Creating a new user
    // pre: request params are the new user name and their email
    // post: true is returned if new user is successfully created, false otherwise
    this.createUser = function(req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL createUser(\''+req.email +'\',\''+req.name+'\')', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    res.send(false);
                    throw err;
                } else {
                    console.log("HELLO THERE!");
                    console.log(result);
                    res.send(true);
                }
            });
        });
    }

}

module.exports = new User();
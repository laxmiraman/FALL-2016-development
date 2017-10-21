var connection = require('../config/db-connection');


function Groups() {

    // Getting a list of all the groups
    // pre: NA
    // post: group ids and names are returned
    this.getGroups = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL getGroups()', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    console.log(res);
                    res.send(result);
                }
            });
        });
    };

    // Getting a list of all the roles
    // pre: NA
    // post: role ids and role names are returned
    this.getRoles = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL getRoles()', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    console.log(res);
                    res.send(result);
                }
            });
        });
    };

    // Getting details of all the group members
    // pre: request param is the group id of the specific group
    // post: the details of the group members are returned (name, email, phone, etc)
    this.getMembers = function(req, res) {
        connection.acquire(function (err, con) {
            var x = req.query.groupID;
            con.query('CALL getGroupMembers('+req.query.groupID+')', req, function (err, result) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    console.log(res);
                    res.send(result);
                }
            });
        });
    }


    // Creating a new group
    // pre: request params are the new group name and the role id it is associated with
    // post: true is returned if group is successfully created, false otherwise
    this.createNewGroup = function(req, res) {
        connection.acquire(function (err, con) {           
            var query = 'CALL createGroup(\''+req.groupName.replace(/'/g, "\\'") +'\','+req.roleID+')';
            con.query('CALL createGroup(\''+req.groupName.replace(/'/g, "\\'") +'\','+req.roleID+')', req, function (err, result) {
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
    }


    // Move user to another group
    // pre: request params are the userID and the new group ID
    // post: true is returned if the user has been successfully moved
    this.moveUser = function(req, res) {
        connection.acquire(function (err, con) {           
            var query = 'CALL moveUser('+req.userID +','+req.groupID+')';
            con.query('CALL moveUser('+req.userID +','+req.groupID+')', req, function (err, result) {
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
    }


}

module.exports = new Groups();
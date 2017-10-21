var userService = require('../services/user-service.js');

module.exports = {
    configure: function (app) {

        app.get('/user', function (req, res) {
            userService.getUserByEmail(req, res);
        });

        app.post('/create_user/', function (req, res) {
            userService.createUser(req.body, res);
        });
    }
};
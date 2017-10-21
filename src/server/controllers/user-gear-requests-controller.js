var gearRequestService = require('../services/user-gear-requests-service.js');

module.exports = {
    configure: function (app) {

        app.get('/get_user_gear_requests/', function(req, res) {
            gearRequestService.get(req, res);
        });

    }
};
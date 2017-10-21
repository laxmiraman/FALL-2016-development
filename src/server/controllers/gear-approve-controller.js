var gearRequestService = require('../services/gear-approve-service.js');

module.exports = {
    configure: function (app) {

        app.get('/get_requests/', function(req, res) {
            gearRequestService.get(req, res);
        });

        app.post('/approve_request/', function (req, res) {
            gearRequestService.post(req, res);
        });
    }
};
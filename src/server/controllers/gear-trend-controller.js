var gearRequestService = require('../services/gear-trend-service.js');

module.exports = {
    configure: function (app) {

        app.get('/gear_trend/', function (req, res) {
            gearRequestService.get(req, res);
        });
    }
};
var gearService = require('../services/gear-service.js');

module.exports = {
    configure: function (app) {
        app.get('/gear_availability/', function (req, res) {
            gearService.get(req, res);
        });
    }
};
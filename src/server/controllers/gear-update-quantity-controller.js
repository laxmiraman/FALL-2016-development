var gearService = require('../services/gear-update-quantity-service.js');

module.exports = {
    configure: function (app) {
        app.post('/update_gear_quantity/', function (req, res) {
            gearService.post(req.body, res);
        });
    }
};



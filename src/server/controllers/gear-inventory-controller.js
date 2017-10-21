var gearInventoryService = require('../services/gear-inventory-service.js');

module.exports = {
    configure: function (app) {
        app.get('/gear_inventory/', function (req, res) {
            gearInventoryService.get(req, res);
        });
    }
};
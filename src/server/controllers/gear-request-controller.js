var gearRequestService = require('../services/gear-request-service.js');

module.exports = {
    configure: function (app) {
        app.get('/request/:id', function(req, res) {
            gearRequestService.get(req.params.id, res);
        });

        app.post('/request/', function (req, res) {
            gearRequestService.post(req.body, res);
        });
    }
};
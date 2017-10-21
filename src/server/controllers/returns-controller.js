var gearReturnService = require('../services/gear-return-service.js');

module.exports = {
    configure: function (app) {  
        app.get('/returns', function (req, res) {
          gearReturnService.viewAllReturns(req, res);
        });
        
        app.get('/returns/confirm', function (req, res) {
          gearReturnService.confirmReturn(req, res);
        });
        
        app.get('/requestdetail', function (req, res) {
          gearReturnService.requestDetail(req, res);
        });

    }
};
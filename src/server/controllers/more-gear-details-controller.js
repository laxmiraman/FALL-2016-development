var moreGearDetailsService = require('../services/more-gear-details-service.js');

module.exports = {
    configure: function (app) {  
        app.get('/moredetails/:id', function (req, res) {
          moreGearDetailsService.get(req.params.id, res);
        });
    }
};

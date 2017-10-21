var viewHistoryService = require('../services/view-history-service.js');

module.exports = {
    configure: function (app) {
        app.get('/view_history_byTripLeader/', function (req, res) {
            viewHistoryService.viewByTripLeader(req, res);
        });

        app.get('/view_history_byDate/', function (req, res) {
            viewHistoryService.viewByDate(req, res);
        });
    }
};
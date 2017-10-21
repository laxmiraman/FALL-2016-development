var groupManagerService = require('../services/group-manager-service.js');

module.exports = {
    configure: function (app) {

        app.get('/groups/', function (req, res) {
            groupManagerService.getGroups(req, res);
        });

        app.get('/roles/', function (req, res) {
            groupManagerService.getRoles(req, res);
        });

        app.get('/group_members/', function(req, res) {
            groupManagerService.getMembers(req, res);
        });

        app.post('/create_group/', function (req, res) {
            groupManagerService.createNewGroup(req.body, res);
        });

        app.post('/move_user/', function (req, res) {
            groupManagerService.moveUser(req.body, res);
        });
    }
};
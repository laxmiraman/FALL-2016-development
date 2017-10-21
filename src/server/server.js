var express = require('express');
var connection = require('./config/db-connection');
var bodyparser = require('body-parser');
var CronJob = require('cron').CronJob;
var gearReturnsController = require('./controllers/returns-controller');
var gearRequestController = require('./controllers/gear-request-controller');
var gearController = require('./controllers/gear-controller');
var gearInventoryController = require('./controllers/gear-inventory-controller');
var gearUpdateQuantityController = require('./controllers/gear-update-quantity-controller');
var notifyService = require('./services/notify-service');
var moreGearDetailsController = require('./controllers/more-gear-details-controller');
var gearApproveController = require('./controllers/gear-approve-controller');
var gearTrendController = require('./controllers/gear-trend-controller');
var viewHistoryController = require('./controllers/view-history-controller');
var gearInventoryController = require('./controllers/gear-inventory-controller');
var groupManagerController = require('./controllers/group-manager-controller');
var userController = require('./controllers/user-controller');
var userGearRequestsController = require('./controllers/user-gear-requests-controller');
var app = express();


// Configured app with body parser for accepting POST requests.
app.use(bodyparser.urlencoded({ extended: true }));
app.use(bodyparser.json());

app.all('*', function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    req.header('Access-Control-Allow-Origin', '*');
    req.header('Access-Control-Allow-Header', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});

connection.init();
gearRequestController.configure(app);
gearReturnsController.configure(app);
gearController.configure(app);
gearInventoryController.configure(app);
gearUpdateQuantityController.configure(app);
gearApproveController.configure(app);
gearTrendController.configure(app);
moreGearDetailsController.configure(app);
viewHistoryController.configure(app);
gearInventoryController.configure(app);
groupManagerController.configure(app);
userController.configure(app);
userGearRequestsController.configure(app);

var server = app.listen(8000, function () {
    console.log('Server listening on port ' + server.address().port);
});

/* This cron job is for user story 6 (email notifications).
 * It has (arbitrarily) been set to run every day at noon. It is also
 * turned off by default to prevent inadvertent email spamming. To test
 * the notifications, set the start flag to 'true' and choose an 
 * appropriate time interval.
 */
var job = new CronJob('00 00 12 * * *', function() {
    /* run job */
    notifyService.Notify();

    }, function() {
        console.log('notification job has been stopped');
    },
    false,   /* disable the job by default */
    'America/Los_Angeles' /* time zone is set to PST */
);
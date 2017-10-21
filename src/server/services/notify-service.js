var connection = require('../config/db-connection');
var nodemailer = require('nodemailer');

/* Create object to store the email server config options
 * for our transporter to use. This email acount actually
 * exists but please don't abuse it. Gmail only allows a 
 * limited number of sent emails per day (100-150).
 */
var smtpConfig = {
    host: 'smtp.gmail.com',
    port: '465',
    secure: true,
    auth: {
        user: 'wta.gear.lending.library@gmail.com',
        pass: 'segr5260_fall2016'
    }
};
var transporter = nodemailer.createTransport(smtpConfig);

/* The 'from:' line to use in sending emails */
var FROM_ADDR = '"Matt Smith" <wta.gear.lending.library@gmail.com>';

/* Number days ahead of the event to notify the users by */
var DAYS_FROM_EVENT = 2;

module.exports = {
    Notify: function() {
        console.log('Notify() ran');

        /* Check database for upcoming gear pickups and notify user/admins if so */
        connection.acquire(function (err, con) {
            con.query('CALL get_upcoming_pickups(' + DAYS_FROM_EVENT + ')', function (err, pickups) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    for (var i = 0; i < pickups[0].length; i++) {
                        getAdminsAndSend(pickups[0][i], 'pickup');
                    };
                }
            });
        });

        /* Check database for upcoming gear returns and notify user/admins if so */
        connection.acquire(function (err, con) {
            con.query('CALL get_upcoming_returns(' + DAYS_FROM_EVENT + ')', function (err, returns) {
                con.release();
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                    for (var i = 0; i < returns[0].length; i++) {
                        getAdminsAndSend(returns[0][i], 'return');
                    };
                }
            });
        });

        /* If upcoming pickup/return was found, then notify that user along with 
         * all system admins.
         */
        function getAdminsAndSend(eventData, eventName) {
            connection.acquire(function (err, con) {
                con.query('CALL get_admin_emails()', function (err, admins) {
                    con.release();
                    if (err) {
                        console.log(err);
                        throw err;
                    } else {
                        /* Creat mailOption object which contains all information necessary to
                         * have our transporter send an email.
                         */
                        var userMailOptions = {
                            from: FROM_ADDR,
                            to: eventData.email,
                            subject: 'Your WTA gear ' + eventName + ' is in ' + DAYS_FROM_EVENT + ' days',
                            text: 'Hello ' + eventData.name + ',\nYour gear request ' + eventName + ' from WTA is in ' + DAYS_FROM_EVENT + ' days!'
                        };

                        transporter.sendMail(userMailOptions, function (err, result) {
                            if (err) {
                                console.log(err);
                                throw err;
                            }
                            console.log('Message sent: ' + result.response);
                        });

                        /* Make sure that our database actually contained admin users (it should!)
                         * then iterate over the list of their emails to build the 'to:' list
                         * for the admin email. Afterward, send them all an email similar to what
                         * we sent the user.
                         */
                        if (admins[0].length > 0) {
                            var adminToList = admins[0][0].email
                            for (var i = 1; i < admins[0].length; i++) {
                                adminToList += ', ' + admins[0][i].email
                            }

                            var adminMailOptions = {
                                from: FROM_ADDR,
                                to: adminToList,
                                subject: 'Upcoming gear ' + eventName + ' in ' + DAYS_FROM_EVENT + ' days',
                                text: eventData.name + ' is coming to ' + eventName + ' their gear request in ' + DAYS_FROM_EVENT + ' days.'
                            };

                            transporter.sendMail(adminMailOptions, function (err, result) {
                                if (err) {
                                    console.log(err);
                                    throw err;
                                }
                                console.log('Message sent: ' + result.response);
                            });
                        }
                    }
                });
            });
        }
    }
};
 
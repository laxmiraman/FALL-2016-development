var connection = require('../config/db-connection');

function separateRequestData(results) {
  var rqId = -1;
  var requests = [];
  var request;
  for(var i = 0; i < results.length; i++) {
    var currRqId = results[i].request_id;
    if(rqId != currRqId) {
      rqId = currRqId;
      if(i > 0) {
      requests.push(request);
      }
      request = { 
        requestId: results[i].request_id, 
        borrower: results[i].borrower,
        status: results[i].status,
        dueDate: results[i].due_date, 
        items: [] 
      };
    }
    request.items.push(results[i]);
  }
  if(typeof request != 'undefined') {
    requests.push(request);
  }
  return requests;
}

function Request() {

    // Getting request details
    this.viewAllReturns = function (req, res) {
        connection.acquire(function (err, con) {
            con.query('CALL RequestsDueForReturn()', req, function (err, result) {
                con.release();    
                if (err) {
                    console.log(err);
                    throw err;
                } else {
                  res.send(separateRequestData(result[0]));
                }
            });    
        });
    };

    this.confirmReturn = function (req, res) {
      var id = req.query.id;
      console.log('Going to update request with id ' + id + ' as verified returned');
      var qry = `CALL MarkRequestReturned(\'${id}\');`;
        connection.acquire(function (err, con) {
          con.query(qry, req, function (err, result) {
              con.release();    
              var response = {};
              if (err) {
                response.success = 'false';
              } else {
                response.success = 'true';
              }
              res.send(response);
          });
      });
    };
    
    this.requestDetail = function (req, res) {
      var id = req.query.id;
      console.log('data requestdetail called ' + id);
      var qry = `CALL ViewRequestDetail(\'${id}\');`;
      connection.acquire(function (err, con) {
          con.query(qry, req, function (err, rows) {
              con.release();    
              if (err) res.send({ error: err });
              var requests = separateRequestData(rows[0]);
              res.send(requests);
          });
      });
    };
    
}

module.exports = new Request();
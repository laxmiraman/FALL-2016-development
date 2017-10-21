(function() {
  'use strict';
  
  var baseUrl = "http://localhost:8000";
  
  angular.module('wta.api')
    .factory('WtaApi', WtaApi);
  
  WtaApi.$inject = [ '$http', 'logger' ];
  function WtaApi( $http, logger ) {
    var vm = this;
    
    var service = {
      createRequest : createRequest,
      getAvailableGear: getAvailableGear,
      findAllGear: findAllGear,
      updateGearQuantity: updateGearQuantity,
      getRequestSummary: getRequestSummary,
      getReturns: getReturns,
      confirmReturn: confirmReturn,
      getGearRequests: getGearRequests,
      approveRequest: approveRequest,
      getGearTrend: getGearTrend,
      getHistoryByDate: getHistoryByDate,
      getHistoryByTripLeader: getHistoryByTripLeader,
      getGearDetails: getGearDetails,
      getGroups: getGroups,
      getGroupMembers: getGroupMembers,
      getRoles: getRoles,
      createGroup: createGroup,
      moveUser: moveUser,
      getUserByEmail: getUserByEmail,
      createUser: createUser,
      getUserGearRequests: getUserGearRequests,
    }
    return service;
    
    /////////////////////

    function createRequest(startDate, endDate, gears, userId) {
      var createRequestUrl = baseUrl + '/request/';
      var gearRequest = {
        "startdate": startDate,
        "enddate": endDate,
        "gears": gears,
        "userId": userId,
      }
      return $http.post(createRequestUrl, gearRequest)
        .then(createRequestComplete)
        .catch(createRequestFailed);
        
      function createRequestComplete(response) {
          return response.data;
      }
      
      function createRequestFailed(error) {
          logger.error('XHR Failed for POST CreateRequest '+error.data);
      }
    }

    function createGroup(groupName, roleID) {
      var createGroupUrl = baseUrl + '/create_group/';
      var groupRequest = {
        "groupName": groupName,
        "roleID": roleID
      }
      return $http.post(createGroupUrl, groupRequest)
        .then(createGroupCompleted)
        .catch(createGroupFailed);
        
      function createGroupCompleted(response) {
          return response.data;
      }
      
      function createGroupFailed(error) {
          logger.error('XHR Failed for POST CreateGroup '+error.data);
      }
    }

    function moveUser(groupID, userID) {
      var moveUserUrl = baseUrl + '/move_user/';
      var groupRequest = {
        "groupID": groupID,
        "userID": userID
      }
      return $http.post(moveUserUrl, groupRequest)
        .then(moveUserCompleted)
        .catch(moveUserFailed);
        
      function moveUserCompleted(response) {
          return response.data;
      }
      
      function moveUserFailed(error) {
          logger.error('XHR Failed for POST moveUser '+error.data);
      } 
    }

    function getAvailableGear(startDate, endDate) {
      var getAvailableGearUrl = baseUrl + '/gear_availability/';
      getAvailableGearUrl += '?startdate=' + startDate + '&enddate=' + endDate;
      return $http.get(getAvailableGearUrl)
        .then(getAvailableGearComplete)
        .catch(getAvailableGearFailed);

      function getAvailableGearComplete(response) {
        return response.data[0];
      }

      function getAvailableGearFailed(error) {
        logger.error('XHR Failed for GET AvailableGear ' + error.data);
      }
    }

    function getGroupMembers(groupID) {
      var getGroupMembersUrl = baseUrl + '/group_members/';
      getGroupMembersUrl += '?groupID=' + groupID;
      return $http.get(getGroupMembersUrl)
        .then(getGroupMembersComplete)
        .catch(getGroupMembersFailed);

      function getGroupMembersComplete(response) {
        return response.data[0];
      }

      function getGroupMembersFailed(error) {
        logger.error('XHR Failed for GET Group Members ' + error.data);
      }
    }

    function getGroups() {
      var getAvailableGearUrl = baseUrl + '/groups/';
      return $http.get(getAvailableGearUrl)
        .then(getGroupsComplete)
        .catch(getGroupsFailed);

      function getGroupsComplete(response) {
        return response.data[0];
      }

      function getGroupsFailed(error) {
        logger.error('XHR Failed for GET GetGroups ' + error.data);
      }
    }

    function getUserByEmail(email) {
      var getUserByEmailUrl = baseUrl + '/user?email=' + email;
      return $http.get(getUserByEmailUrl)
        .then(getUserByEmailComplete)
        .catch(getUserByEmailFailed);

      function getUserByEmailComplete(response) {
        return response.data[0][0];
      }

      function getUserByEmailFailed(error) {
        logger.error('XHR Failed for GET GetUserByEmail: ' + error.info);
      } 
    }

    function createUser(email, name) {
      var createUserUrl = baseUrl + '/create_user/';
      var user = {
        email: email,
        name: name
      };
      return $http.post(createUserUrl, user)
        .then(createUserComplete)
        .catch(createUserFailed);

      function createUserComplete(response) {
        return response.data;
      }

      function createUserFailed(error) {
        logger.error('XHR Failed for POST CreateUser: ' + error.info);
      }
    }

    function getRoles() {
      var getRolesUrl = baseUrl + '/roles/';
      return $http.get(getRolesUrl)
        .then(getRolesComplete)
        .catch(getRolesFailed);

      function getRolesComplete(response) {
        return response.data[0];
      }

      function getRolesFailed(error) {
        logger.error('XHR Failed for GET getRoles ' + error.data);
      }
    }

    function findAllGear() {
      var findAllGearUrl = baseUrl + '/gear_inventory/';
      return $http.get(findAllGearUrl)
        .then(findAllGearComplete)
        .catch(findAllGearFailed);

      function findAllGearComplete(response) {
        return response.data[0];
      }

      function findAllGearFailed(error) {
        logger.error('XHR Failed for GET AllGear ' + error.data);
      }
    }

    function updateGearQuantity(gearid, gearquantity) {
      var updateGearQuantityUrl = baseUrl + '/update_gear_quantity/';
      var gearRequest = {
        "gearid": gearid,
        "gearquantity": gearquantity
      }
      return $http.post(updateGearQuantityUrl, gearRequest)
        .then(updateGearQuantityComplete)
        .catch(updateGearQuantityFailed);
        
      function updateGearQuantityComplete(response) {
          return response.data;
      }
      
      function updateGearQuantityFailed(error) {
          logger.error('XHR Failed for POST UpdateGearQuantity '+error.data);
      }
    }

    function getRequestSummary(requestID) {
      var getRequestSummaryUrl = baseUrl + '/request/'+requestID;
      return $http.get(getRequestSummaryUrl)
        .then(getRequestSummaryComplete)
        .catch(getRequestSummaryFailed);

      function getRequestSummaryComplete(response) {
        return response.data[0];
      }

      function getRequestSummaryFailed(error) {
        logger.error('XHR Failed for Get RequestSummary ' + error.data);
      }
    }
    
    function getReturns() {
      console.log('Going to call get returns');
      var getReturnsUrl = baseUrl + '/returns/';
      return $http.get(getReturnsUrl)
        .then(getReturnsComplete)
        .catch(getReturnsFailed);

      function getReturnsComplete(response) {
        console.log('response for get returns received');
        console.log(response.data);
        console.log('number of returns ' + response.data.length);
        return response.data;
      }

      function getReturnsFailed(error) {
        logger.error('XHR Failed for Get RequestSummary ' + error.data);
      }
    }
    
    function confirmReturn(requestId) {
      var confirmReturnsUrl = baseUrl + '/returns/confirm?id=' + requestId;
      return $http.get(confirmReturnsUrl)
        .then(confirmReturnsComplete)
        .catch(confirmReturnsFailed);

      function confirmReturnsComplete(response) {
        return response.data;
      }

      function confirmReturnsFailed(error) {
        logger.error('XHR Failed for Get RequestSummary ' + error.data);
      }
    }

    function getGearRequests() {
      var getGearRequestsUrl = baseUrl + '/get_requests/';
      return $http.get(getGearRequestsUrl)
        .then(getGearRequestsComplete)
        .catch(getGearRequestsFailed);

      function getGearRequestsComplete(response) {
        return response.data[0];
      }

      function getGearRequestsFailed(error) {
        logger.error('XHR Failed for GET GearRequests' + error.data);
      }
    }

    function getUserGearRequests(userId) {
      var getUserGearRequestsUrl = baseUrl + '/get_user_gear_requests/?userId=' + userId;
      return $http.get(getUserGearRequestsUrl)
        .then(getUserGearRequestsComplete)
        .catch(getUserGearRequestsFailed);

      function getUserGearRequestsComplete(response) {
        return response.data[0];
      }

      function getUserGearRequestsFailed(error) {
        logger.error('XHR Failed for GET GearRequests' + error.data);
      }
    }

    function approveRequest(requestId) {
      var approveRequestUrl = baseUrl + '/approve_request/?requestId='+requestId;
      return $http.post(approveRequestUrl,"")
        .then(approveRequestComplete)
        .catch(approveRequestFailed);
        
      function approveRequestComplete(response) {
          return response.data;
      }
      
      function approveRequestFailed(error) {
          logger.error('XHR Failed for POST ApproveRequest '+error.data);
      }
    }

    function getGearTrend(year) {
      var gearTrendUrl = baseUrl + '/gear_trend/?trendYear='+year;
      return $http.get(gearTrendUrl)
        .then(gearTrendComplete)
        .catch(gearTrendFailed);
        
      function gearTrendComplete(response) {
          return response.data[0];
      }
      
      function gearTrendFailed(error) {
          logger.error('XHR Failed for POST GearTrend '+error.data);
      }
    }

    function getHistoryByDate(startDate, endDate) {
      var getHistoryUrl = baseUrl + '/view_history_byDate/';
      getHistoryUrl += '?startdate=' + startDate + '&enddate=' + endDate;
      return $http.get(getHistoryUrl)
        .then(getHistoryComplete)
        .catch(getHistoryFailed);

      function getHistoryComplete(response) {
        return response.data[0];
      }

      function getHistoryFailed(error) {
        logger.error('XHR Failed for GET History by Date ' + error.data);
      }
    }

    function getHistoryByTripLeader(name) {
      console.log('In get history by trip leader: ' + name);
      var getHistoryUrl = baseUrl + '/view_history_byTripLeader';
      getHistoryUrl += '?name=' + name;
      return $http.get(getHistoryUrl)
        .then(getHistoryComplete)
        .catch(getHistoryFailed);

      function getHistoryComplete(response) {
        return response.data[0];
      }

      function getHistoryFailed(error) {
        logger.error('XHR Failed for GET History by Date ' + error.data);
      }
    }

    function getGearDetails(gearId) {
      var getGearDetailsUrl = baseUrl + '/moredetails/'+gearId;
      return $http.get(getGearDetailsUrl)
        .then(getGearDetailsComplete)
        .catch(getGearDetailsFailed);

      function getGearDetailsComplete(response) {
        return response.data[0];
      }

      function getGearDetailsFailed(error) {
        logger.error('XHR Failed for GET Gear Details ' + error.data);
      }
    }    
    
  }
  
})();
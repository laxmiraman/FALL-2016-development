(function() {
  'use strict';

  angular
    .module('wta.request-summary')
    .controller('RequestSummaryController', RequestSummaryController);

  RequestSummaryController.$inject = ['logger', 'WtaApi', 'ProfileAccess'];
  function RequestSummaryController(logger, WtaApi, ProfileAccess) {
    var vm = this;

    vm.startDate = '';
    vm.endDate = '';
    vm.requestDetails = [];
    vm.headerText = 'Gear Requests';
    var profile = ProfileAccess.getProfile();
    vm.gearRequestsPage = false;
    vm.requestDetailPage = false;
    vm.getUserGearRequests = getUserGearRequests;
    vm.getRequestDetails = getRequestDetails;

    activate();
    
    /////////////////////

    function activate() {
      // TODO: take this request id as a route parameter from whatever other table links
      // to this page.
      vm.gearRequestsPage = true;
      vm.requestDetailPage = false;
      vm.getUserGearRequests();
    }

    function getUserGearRequests() {
      WtaApi.getUserGearRequests(profile.user_id).then(function(userGearRequests) {
        vm.gearRequests = userGearRequests;
      });
    }

    function getRequestDetails(requestID) {
      WtaApi.getRequestSummary(requestID).then(function(requestDetails) {
        vm.requestDetails = requestDetails;
        vm.startDate = vm.requestDetails[0].start_date.substring(0, vm.requestDetails[0].start_date.indexOf('T'));
        vm.endDate = vm.requestDetails[0].end_date.substring(0, vm.requestDetails[0].end_date.indexOf('T'));
      });
      vm.gearRequestsPage = false;
      vm.requestDetailPage = true;
      vm.headerText = 'Request Summary';
    }

  }
})();
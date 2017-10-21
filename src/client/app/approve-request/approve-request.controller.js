(function() {
  'use strict';

  angular
    .module('wta.approve-request')
    .controller('ApproveRequestController', ApproveRequestController);

  ApproveRequestController.$inject = ['logger', 'WtaApi'];
  function ApproveRequestController(logger, WtaApi) {
    var vm = this;

    vm.gearRequests = [];
    vm.requestDetails = [];
    vm.headerText = "";
    vm.requestId = "";
    vm.startDate = "";
    vm.endDate = "";
    vm.requester = "";
    vm.status = "";


    vm.gearRequestsPage = false;
    vm.requestDetailPage = false;
    vm.approveConfirmPage = false;

    vm.getGearRequests = getGearRequests;
    vm.approveRequest = approveRequest;
    vm.getRequestDetail = getRequestDetail;
    vm.activate = activate;

    activate();

    function activate() {
      logger.info("Activated Approve Request");
      vm.gearRequestsPage = true;
      vm.requestDetailPage = false;
      vm.approveConfirmPage = false;
      vm.headerText = "Gear Requests";
      vm.getGearRequests();
    }

    function getGearRequests() {
      WtaApi.getGearRequests().then(function(gearRequests) {
        vm.gearRequests = gearRequests;
      });
    }

    function getRequestDetail(requestId, requester, status) {
      WtaApi.getRequestSummary(requestId).then(function(requestDetails) {
        vm.requestDetails = requestDetails;
        vm.startDate = vm.requestDetails[0].start_date.substring(0, vm.requestDetails[0].start_date.indexOf('T'));
        vm.endDate = vm.requestDetails[0].end_date.substring(0, vm.requestDetails[0].end_date.indexOf('T'));
      });
      vm.status = status;
      vm.requester = requester;
      vm.requestId = requestId;
      vm.gearRequestsPage = false;
      vm.requestDetailPage = true;
      vm.approveConfirmPage = false;
      vm.headerText = 'Request Summary';
    }

    function approveRequest() {
      WtaApi.approveRequest(vm.requestId).then(function(res) {
        if( res === true ) {
          vm.gearRequestsPage = false;
          vm.requestDetailPage = false;
          vm.approveConfirmPage = true;
          vm.headerText = 'Request Approved';
        } else {
          // error handle
        }
      });
    }
    
  }
})();
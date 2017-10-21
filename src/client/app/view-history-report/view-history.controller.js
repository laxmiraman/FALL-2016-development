(function() {
  'use strict';

  angular
    .module('wta.view-history-report')
    .controller('ViewHistoryReportController', ViewHistoryReportController);

  ViewHistoryReportController.$inject = ['logger', 'WtaApi'];

  //activate();
  function ViewHistoryReportController(logger, WtaApi) {
    var vm = this;

    var date = new Date();
    vm.startDate = date.toISOString().substring(0, date.toISOString().indexOf('T'));
    vm.endDate = '';
    vm.reports = [];
    vm.headerText = 'View History Report';
    vm.tripLeader = 'Joe Gearborrower';

    vm.getHistoryReport = getHistoryReport;
    vm.getHistoryReportByTripLeader = getHistoryReportByTripLeader;

    activate();
    
    /////////////////////

    function activate() {
      logger.info("Activated Create Request");
    }

    function getHistoryReport() {
      var startDate = vm.startDate.toISOString().substring(0, vm.startDate.toISOString().indexOf('T'));
      var endDate = vm.endDate.toISOString().substring(0, vm.endDate.toISOString().indexOf('T'));
      WtaApi.getHistoryByDate(startDate, endDate).then(function(gears) {
        vm.reports = gears;
      });
    }

    function getHistoryReportByTripLeader() {
      console.log('Get history report by trip leader: ' + vm.tripLeader);
      WtaApi.getHistoryByTripLeader(vm.tripLeader).then(function(gears) {
        vm.reports = gears;
        console.log(vm.reports);
        return vm.reports;
      });
    }
    
  }
})();
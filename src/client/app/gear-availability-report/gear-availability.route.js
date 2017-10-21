(function() {
  'use strict';

  angular
    .module('wta.gear-availability-report')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'gearAvailabilityReport',
        config: {
          url: '/gear-availability-repot',
          templateUrl: '/src/client/app/gear-availability-report/gear-availability-report.html',
          controller: 'GearAvailabilityReportController',
          controllerAs: 'vm',
          title: 'Gear Availability Report'
        }
      }
    ];
  }
})();
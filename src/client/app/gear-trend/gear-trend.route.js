(function() {
  'use strict';

  angular
    .module('wta.gear-trend')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'gearTrend',
        config: {
          url: '/gear-trend',
          templateUrl: '/src/client/app/gear-trend/gear-trend.html',
          controller: 'GearTrendController',
          controllerAs: 'vm',
          title: 'Gear Trend'
        }
      }
    ];
  }
})();
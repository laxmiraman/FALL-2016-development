(function() {
  'use strict';

  angular
    .module('wta.request-summary')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'requestSummary',
        config: {
          url: '/request-summary',
          templateUrl: '/src/client/app/request-summary/request-summary.html',
          controller: 'RequestSummaryController',
          controllerAs: 'vm',
          title: 'Request Summary'
        }
      }
    ];
  }
})();
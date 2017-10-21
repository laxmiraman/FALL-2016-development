(function() {
  'use strict';

  angular
    .module('wta.approve-request')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'approveRequest',
        config: {
          url: '/approve-request',
          templateUrl: '/src/client/app/approve-request/approve-request.html',
          controller: 'ApproveRequestController',
          controllerAs: 'vm',
          title: 'Approve Request'
        }
      }
    ];
  }
})();
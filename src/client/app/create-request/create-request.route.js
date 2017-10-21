(function() {
  'use strict';

  angular
    .module('wta.create-request')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'createRequest',
        config: {
          url: '/create-request',
          templateUrl: '/src/client/app/create-request/create-request.html',
          controller: 'CreateRequestController',
          controllerAs: 'vm',
          title: 'Create Request'
        }
      }
    ];
  }
})();
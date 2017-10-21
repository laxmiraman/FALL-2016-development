(function() {
  'use strict';

  angular
    .module('wta.manage-returns')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'manageReturns',
        config: {
          url: '/manage-returns',
          templateUrl: '/src/client/app/manage-returns/manage-returns.html',
          controller: 'ManageReturnsController',
          controllerAs: 'vm',
          title: 'Manage Returns'
        }
      }
    ];
  }
})();
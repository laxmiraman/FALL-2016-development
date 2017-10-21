(function() {
  'use strict';

  angular
    .module('wta.group-manager')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'groupManager',
        config: {
          url: '/group-manager',
          templateUrl: '/src/client/app/group-manager/group-manager.html',
          controller: 'GroupManagerController',
          controllerAs: 'vm',
          title: 'Group Manager'
        }
      }
    ];
  }
})();
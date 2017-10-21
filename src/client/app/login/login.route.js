(function() {
  'use strict';

  angular
    .module('wta.login')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'login',
        config: {
          url: '/login',
          templateUrl: '/src/client/app/login/login.html',
          controller: 'LoginController',
          controllerAs: 'vm',
          title: 'Login'
        }
      }
    ];
  }
})();
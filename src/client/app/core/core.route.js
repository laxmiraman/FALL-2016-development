(function() {
  'use strict';

  angular
    .module('wta.core')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    var otherwise = '/create-request';
    routerHelper.configureStates(getStates(), otherwise);
  }

  function getStates() {
    return [
      {
        state: '404',
        config: {
          url: '/404',
          templateUrl: '/src/client/app/core/404.html',
          title: '404'
        }
      }
    ];
  }
})();
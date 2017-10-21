(function() {
  'use strict';

  angular
    .module('wta.more-gear-details')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'moreGearDetails',
        config: {
          url: '/more-gear-details/:gearID',
          templateUrl: '/src/client/app/more-gear-details/more-gear-details.html',
          controller: 'MoreGearDetailsController',
          controllerAs: 'vm',
          title: 'View More Gear Details'
        }
      }
    ];
  }
})();

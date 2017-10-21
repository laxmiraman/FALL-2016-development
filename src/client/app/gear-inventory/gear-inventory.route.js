(function() {
  'use strict';

  angular
    .module('wta.gear-inventory')
    .run(appRun);

  appRun.$inject = ['routerHelper'];
  function appRun(routerHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return [
      {
        state: 'gearInventory',
        config: {
          url: '/gear-inventory',
          templateUrl: '/src/client/app/gear-inventory/gear-inventory.html',
          controller: 'GearInventoryController',
          controllerAs: 'vm',
          title: 'Gear Inventory'
        }
      }
    ];
  }
})();
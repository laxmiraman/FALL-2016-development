(function() {
  'use strict';

  angular
    .module('wta.more-gear-details')
    .controller('MoreGearDetailsController', MoreGearDetailsController);

  MoreGearDetailsController.$inject = ['$stateParams', 'logger', 'WtaApi']; 

  function MoreGearDetailsController($stateParams, logger, WtaApi) {
    var vm = this;
    vm.gearItem = [];
    vm.id = $stateParams.gearID;
    vm.headerText = 'More Gear Details';

    activate();

    function activate() {
      moreGearDetails();
    }

    function moreGearDetails() {
      WtaApi.getGearDetails(vm.id).then(function(gearItem) {
        vm.gearItem = gearItem;
        return vm.gearItem;
      });
    }
 
  }
})();
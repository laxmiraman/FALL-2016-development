(function() {
  'use strict';

  angular
    .module('wta.gear-inventory')
    .controller('GearInventoryController', GearInventoryController);

GearInventoryController.$inject = ['logger', 'WtaApi', 'ProfileAccess', '$state'];
  
  //activate();
  function GearInventoryController(logger, WtaApi, ProfileAccess, $state) {
    var vm = this;

    var nTemp = 10;
    vm.gearid = nTemp;
    vm.gearquantity = nTemp;
    vm.gears = [];
    vm.headerText = 'Gear Inventory';

    vm.findAllGear = findAllGear;
    vm.updateGearQuantity = updateGearQuantity;
    activate();
    
    /////////////////////

    function activate() {
      var profile = ProfileAccess.getProfile();
      if(profile) {
            vm.authorized = profile.role_id == 2 || profile.role_id == 4;
        } else {
            $state.go('login');
        }
      logger.info("Displayed Gear Inventory");
    }

    function findAllGear() {
      console.log("The findAllGear function has been called successfully");
      WtaApi.findAllGear().then(function(gears) {
        vm.gears = gears;
      });
    }

    function updateGearQuantity() {
      var gearid = vm.gearid;
      var gearquantity = vm.gearquantity;
      WtaApi.updateGearQuantity(gearid, gearquantity).then(function(res) {
        if( res === true ) {
          vm.statustext = 'Gear ID of ' + gearid + ' -> quantity updated to ' + gearquantity + '!';
          // Refresh data on the page
          findAllGear();
        } else {
          // error handle
        }
      });
    }
    
  }
})();

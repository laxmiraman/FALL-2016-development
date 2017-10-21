(function() {
  'use strict';

  angular
    .module('wta.create-request')
    .controller('CreateRequestController', CreateRequestController);

  CreateRequestController.$inject = ['logger', 'WtaApi', 'ProfileAccess', '$state'];

  function CreateRequestController(logger, WtaApi, ProfileAccess, $state) {
    var vm = this;
    vm.authorized = false;

    var date = new Date();
    vm.startDate = date;
    vm.endDate = date;

    vm.altInputFormats = ['M!/d!/yyyy'];

    vm.startDatePopup = {
      opened: false
    };

    vm.endDatePopup = {
      opened: false
    };

    vm.dateOptions = {
      maxDate: new Date(2020, 5, 22),
      minDate: new Date(),
      startingDay: 1
    };

    vm.gears = [];
    vm.initialGears = [];
    vm.needToCheckout = true;
    vm.headerText = 'Available Gear:';
    vm.requestSuccessful = false;
    vm.gearsWithValidQuantity = [];
    vm.isInValidQuantity = false;

    vm.findAvailableGear = findAvailableGear;
    vm.proceedToCheckout = proceedToCheckout;
    vm.createRequest = createRequest;
    vm.goBack = goBack;
    vm.invalidRequest = invalidRequest;
    vm.openStartPicker = openStartPicker;
    vm.openEndPicker = openEndPicker;
    vm.validDates = validDates;

    var profile = ProfileAccess.getProfile();

    activate();
    
    /////////////////////

    function activate() {
      var profile = ProfileAccess.getProfile();
      if(profile) {
        vm.authorized = profile.role_id == 3;
      } else {
        $state.go('login');
      }
      logger.info("Activated Create Request");
    }

    function findAvailableGear() {
      var startDate = vm.startDate.toISOString().substring(0, vm.startDate.toISOString().indexOf('T'));
      var endDate = vm.endDate.toISOString().substring(0, vm.endDate.toISOString().indexOf('T'));
      WtaApi.getAvailableGear(startDate, endDate).then(function(gears) {
        vm.gears = gears;
      });
    }

    function createRequest() {
      if (!vm.authorized) {
        return;
      }
      var startDate = vm.startDate.toISOString().substring(0, vm.startDate.toISOString().indexOf('T'));
      var endDate = vm.endDate.toISOString().substring(0, vm.endDate.toISOString().indexOf('T'));
      WtaApi.createRequest(startDate, endDate, vm.gears, profile.user_id).then(function(res) {
        if( res === true ) {
          vm.requestSuccessful = true;
          vm.headerText = 'Request Submitted!';
        } else {
          // error handle
        }
      });
    }

    function goBack() {
      vm.needToCheckout = true;
      vm.gears = vm.initialGears;
      $('#gear_request_table input').attr('readonly', false);
      vm.headerText = 'Available Gear';
      $('.validator').show();
    }

    function invalidRequest(){
       vm.isInValidQuantity = false;
       vm.gearsWithValidQuantity = vm.gears.filter(function(gear) {
         return gear.quantity !== 0 && gear.quantity !== null && gear.quantity !== undefined;
       });
       if(vm.gearsWithValidQuantity.length == 0){
         vm.isInValidQuantity = true;
       }else{
         vm.gearsWithValidQuantity.forEach(function(element) {
           if (element.quantity > element.QuantityAvailable) {
             vm.isInValidQuantity = true;
           }
         }, this); 
       }
       return vm.isInValidQuantity;
     }

    function proceedToCheckout() {
      $('#gear_request_table input').attr('readonly', 'readonly');
      vm.initialGears = vm.gears;
      
      vm.gears = vm.gears.filter(function(gear) {
        return gear.quantity !== 0 && gear.quantity !== null && gear.quantity !== undefined;
      });
      vm.needToCheckout = false;
      vm.headerText = 'Request Summary';
      $('.validator').hide();
    }

    function openStartPicker() {
      vm.startDatePopup.opened = !vm.startDatePopup.opened;
    }

    function openEndPicker() {
      vm.endDatePopup.opened = !vm.endDatePopup.opened;
    }

    function validDates() {
      return vm.startDate <= vm.endDate;
    }
  }
})();
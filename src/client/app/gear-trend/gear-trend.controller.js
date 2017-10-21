(function() {
  'use strict';

  angular
    .module('wta.gear-trend')
    .controller('GearTrendController', GearTrendController);

  GearTrendController.$inject = ['logger', 'WtaApi', 'ProfileAccess', '$state'];
  function GearTrendController(logger, WtaApi, ProfileAccess, $state) {
    var vm = this;

    vm.gearTrendList = [];
    vm.years = [];
    vm.selectedYear = "";
    vm.getGearTrend = getGearTrend;
    vm.headerText = 'Season Trend Report';
    vm.authorized = false;

    activate();

    function activate() {
        var profile = ProfileAccess.getProfile();
        if(profile) {
            vm.authorized = profile.role_id == 2 || profile.role_id == 4;
        } else {
            $state.go('login');
        }
        var year = new Date().getFullYear();
        vm.selectedYear = year;
        vm.years.push(year);
        for(var i=1;i<20;i++) {
            vm.years.push(year + i);
        }
    }

    function getGearTrend() {
        if(!vm.authorized) {
            return;
        }
        WtaApi.getGearTrend(vm.selectedYear).then(function(gearTrendList) {
        vm.gearTrendList = gearTrendList;
      });
    }    
  }
})();
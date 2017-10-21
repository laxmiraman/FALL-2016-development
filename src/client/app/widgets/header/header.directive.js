(function() {
  'use strict';

  angular
    .module('wta.widgets')
    .directive('header', header);

  function header() {
    //Usage:
    //<header></header>
    var directive = {
      scope: {
      },
      templateUrl: 'src/client/app/widgets/header/header.html',
      restrict: 'E',
      controller: HeaderController,
      controllerAs: 'vm',
      bindToController: true
    };
    return directive;
  }


  HeaderController.$inject = ['$scope','logger', 'ProfileAccess', '$state'];

  function HeaderController($scope, logger, ProfileAccess, $state) {
    var vm = this;
    vm.admin = false;
    var profile = ProfileAccess.getProfile(); 
    
    if(profile) {
        vm.admin = profile.role_id == 1 || profile.role_id == 2;
        vm.trip_leader = profile.role_id == 3;
    } else {
      $state.go('login');
    }
  }
}

)();


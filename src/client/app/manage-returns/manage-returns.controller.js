(function() {
  'use strict';

  angular
    .module('wta.manage-returns')
    .controller('ManageReturnsController', ManageReturnsController);

  ManageReturnsController.$inject = ['logger', 'WtaApi'];
  function ManageReturnsController(logger, WtaApi) {
    var vm = this;

    vm.requests = [];
    vm.headerText = 'Manage Returns';

    activate();
    
    /////////////////////

    function activate() {
      getReturns().then(function(requests) {
        logger.info("Activated Request Summary"); 
      });
    }

    function getReturns() {
      return WtaApi.getReturns().then(function(requests) {
        vm.requests = requests;
        vm.confirmReturned = confirmReturned;
        return vm.requests;
      });
    }
    
    function confirmReturned(requestId) {
      return WtaApi.confirmReturn(requestId).then(activate());
    };

  }
})();
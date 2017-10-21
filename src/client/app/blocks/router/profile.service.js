(function() {
  'use strict';

  var STORAGE_ID = 'wta-profile';

  angular.module('blocks.router')
    .factory('ProfileAccess', ProfileAccess)

  function ProfileAccess() {
    var vm = this;

    vm.profile = null;

    var service = {
      getProfile: getProfile,
      setProfile: setProfile,
      removeProfile: removeProfile,
    };
    return service;

    function getProfile() {
      angular.copy(_getFromLocalStorage(), vm.profile);
      return vm.profile;
    }

    function setProfile(googleUser) {
      vm.profile = googleUser;
      _saveToLocalStorage(vm.profile);
    }

    function removeProfile(authResult) {
      vm.profile = null;
      _saveToLocalStorage(vm.profile);
    }

  }

  function _getFromLocalStorage() {
    return JSON.parse(localStorage.getItem(STORAGE_ID) || '{}');
  }

  function _saveToLocalStorage(profile) {
    localStorage.setItem(STORAGE_ID, JSON.stringify(profile));
  }

})();
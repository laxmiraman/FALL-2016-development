(function() {
  'use strict';

  angular
    .module('wta.login')
    .controller('LoginController', LoginController)

  LoginController.$inject = ['logger', 'ProfileAccess', '$state', 'WtaApi'];
  function LoginController(logger, ProfileAccess, $state, WtaApi) {
    var vm = this;

    vm.options = {
      'onsuccess': onSuccess
    };

    activate();

    function activate() {
      logger.info("Activated LoginController");
    }

    function onSuccess(googleUser) {
      // Profile Email: profile.U3
      // Profile Name: profile.ig
      // Profile Google ID: profile.Eea
      // Profile Google Pic: profile.Paa
      var profile = googleUser.getBasicProfile();
      var profile_id;
      debugger;
      WtaApi.getUserByEmail(profile.U3).then(function(user) {
        if(user) {
          ProfileAccess.setProfile(user);
          profile_id = ProfileAccess.getProfile();
          if (profile_id.role_id == 3) {
            $state.go('createRequest');
          } else {
            $state.go('approveRequest');           
          }
        } else {
          // User doesn't exist
          WtaApi.createUser(profile.U3, profile.ig).then(function(user) {
            WtaApi.getUserByEmail(profile.U3).then(function(user) {
              ProfileAccess.setProfile(user);
              $state.go('createRequest');
            });
          });
        }
      });
      
    }
  }

})();
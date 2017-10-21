(function() {
  'use strict';

  angular
    .module('wta.widgets')
    .directive('googleSignInButton', googleSignInButton);

  function googleSignInButton() {
    //Usage:
    //<google-sign-in-button></google-sign-in-button>
    var directive = {
      scope: {
        buttonId: '@',
        options: '&'
      },
      template: '<div></div>',
      restrict: 'E',
      link: function(scope, element, attrs) {
        var div = element.find('div')[0];
        div.id = attrs.buttonId;
        gapi.signin2.render(div.id, scope.options()); //render a google button, first argument is an id, second options
      }
    };
    return directive;
  }
})();
(function() {
  'use strict';

  angular
    .module('wta.core', [
      'ngAnimate', 'ngSanitize',
      'blocks.exception', 'blocks.logger', 'blocks.router',
      'ui.router', 'ui.bootstrap'
    ]);
})();
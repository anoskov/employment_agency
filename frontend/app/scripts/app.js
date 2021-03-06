'use strict';

angular
  .module('employmentAgencyApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'restangular',
    'smart-table',
    'ui.bootstrap',
    'ngTagsInput'
  ])
  .config(function(RestangularProvider) {
    RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.addResponseInterceptor(function(data, operation, what, url, response, deferred) {
      var extractedData;
      extractedData = data.result;
      return extractedData;
    });
  });

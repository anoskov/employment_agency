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
    'ui.bootstrap'
  ])
  .config(function(RestangularProvider) {
    RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.addResponseInterceptor(function(data, operation, what, url, response, deferred) {
      var extractedData;
      extractedData = data.result;
      extractedData.data = response.data.result;
      return extractedData;
    });
  });

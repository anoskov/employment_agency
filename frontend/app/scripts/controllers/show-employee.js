'use strict';

angular.module('employmentAgencyApp')
  .controller('ShowEmployeeCtrl', function ($scope, $routeParams, Restangular) {
    this.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    Restangular.one('employees', $routeParams.employeeId).get().then(function(response) {
      $scope.employee = response;
    })

  });

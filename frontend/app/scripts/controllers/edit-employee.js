'use strict';

angular.module('employmentAgencyApp')
  .controller('EditEmployeeCtrl', function ($scope, $routeParams, $http, Restangular) {
    this.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.jobStatuses = [
      'Ищу работу',
      'Не ищу работу',
      'Открыт к предложениям'
    ];

    $scope.alerts = [];
    $scope.closeAlert = function(index) {
      $scope.alerts.splice(index, 1);
    };

    Restangular.one('employees', $routeParams.employeeId).get().then(function(response) {
      $scope.employee = response;
    });

    $scope.loadSkills = function(query) {
      return $http.get('/api/v1/skills?query=' + query, { cache: true}).then(function(response) {
        var result = {};
        result.data = response.data.result;
        return result;
      });
    };

    $scope.updateEmployee = function () {
      $scope.employee.skills_attributes = $scope.employee.skills;
      $scope.employee.put().then(function(response){
        var result = response;
        result.type = "success";
        $scope.alerts.push(result);
      }, function(response){
        var result = response.data.result;
        result.type = "danger";
        $scope.alerts.push(result);
      })
    };

  });

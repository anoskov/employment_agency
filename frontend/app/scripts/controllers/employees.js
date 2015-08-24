'use strict';

angular.module('employmentAgencyApp')
  .controller('EmployeesCtrl', function ($scope, Restangular, $modal) {
    this.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.alerts = [];
    $scope.closeAlert = function (index) {
      $scope.alerts.splice(index, 1);
    };

    var baseEmployees = Restangular.all('employees');
    baseEmployees.getList().then(function (employees) {
      $scope.allEmployees = employees;
    });

    $scope.animationsEnabled = true;

    $scope.addEmployee = function () {

      var modalInstance = $modal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'addEmployeeModal.html',
        controller: 'EmployeeModalCtrl',
        resolve: {
          employee: {}
        }
      });

      modalInstance.result.then(function (result) {
        $scope.alerts.push(result.alert);
        $scope.allEmployees.push(result.employee);
      });
    };

    $scope.deleteEmployee = function (id, index) {
      Restangular.one("employees", id).remove().then(function(response) {
        var alert = response;
        alert.type = "success";
        $scope.alerts.push(alert);
        $scope.allEmployees.splice(index, 1);
      }, function(response) {
        var alert = response.data.result;
        alert.type = "danger";
        $scope.alerts.push(alert);
      });
    };

    $scope.toggleAnimation = function () {
      $scope.animationsEnabled = !$scope.animationsEnabled;
    };

  })
  .controller('EmployeeModalCtrl', function (Restangular, $scope, $http, $modalInstance, employee) {

    $scope.modalAlerts = [];
    $scope.closeAlert = function (index) {
      $scope.modalAlerts.splice(index, 1);
    };

    $scope.jobStatuses = [
      'Ищу работу',
      'Не ищу работу'
    ];

    $scope.loadSkills = function(query) {
      return $http.get('/api/v1/skills?query=' + query, { cache: true}).then(function(response) {
        var result = {};
        result.data = response.data.result;
        return result;
      });
    };

    $scope.employee = employee;

    $scope.submitEmployee = function () {
      Restangular.all('employees').post($scope.employee).then(function(response) {
        var result = response;
        $scope.employee.id = result.id;
        $scope.employee.skills = $scope.employee.skills_attributes;
        $scope.employee.name = $scope.employee.fname + ' '  + $scope.employee.lname + ' ' +  $scope.employee.sname;
        var alert = {msg: result.msg, errors: result.errors, type: 'success'};
        $modalInstance.close({employee: $scope.employee, alert: alert});
      }, function(response) {
        var result = response.data.result;
        result.type = "danger";
        $scope.modalAlerts.push(result);
      });
    };

    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };
  });


'use strict';

angular.module('employmentAgencyApp')
  .controller('EditVacancyCtrl', function ($scope, $routeParams, $http, Restangular) {
    this.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.alerts = [];

    $scope.closeAlert = function(index) {
      $scope.alerts.splice(index, 1);
    };

    Restangular.one('vacancies', $routeParams.vacancyId).get().then(function(response) {
      $scope.vacancy = response;
    });

    $scope.loadSkills = function(query) {
      return $http.get('/api/v1/skills?query=' + query, { cache: true}).then(function(response) {
        var result = {};
        result.data = response.data.result;
        return result;
      });
    };

    $scope.updateVacancy = function () {
      $scope.vacancy.skills_attributes = $scope.vacancy.skills;
      $scope.vacancy.put().then(function(response){
        var result = response;
        result.type = "success";
        //$scope.vacancy.skills = $scope.vacancy.skills_attributes;
        $scope.alerts.push(result);
      }, function(response){
        var result = response.data.result;
        result.type = "danger";
        $scope.alerts.push(result);
      })
    };

  });

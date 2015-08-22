'use strict';

angular.module('employmentAgencyApp')
  .controller('EditVacancyCtrl', function ($scope, $routeParams, Restangular) {
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

    var baseSkills = Restangular.all('skills');
    baseSkills.getList().then(function(skills) {
      $scope.skills = skills
    });

    $scope.updateVacancy = function () {
      $scope.vacancy.skills_attributes = $scope.vacancy.skills.concat($scope.vacancy.selected_skills);
      $scope.vacancy.put().then(function(response){
        var result = response;
        result.type = "success";
        $scope.vacancy.skills = $scope.vacancy.skills_attributes;
        $scope.alerts.push(result);
      }, function(response){
        var result = response.data.result;
        result.type = "danger";
        $scope.alerts.push(result);
      })
    };

  });

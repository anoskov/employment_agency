'use strict';

angular.module('employmentAgencyApp')
  .controller('ShowVacancyCtrl', function ($scope, $routeParams, Restangular) {
    this.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    Restangular.one('vacancies', $routeParams.vacancyId).get().then(function(response) {
      $scope.vacancy = response;
    })

  });

'use strict';

angular.module('employmentAgencyApp')
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .when('/vacancies', {
        templateUrl: 'views/vacancies.html',
        controller: 'VacanciesCtrl',
        controllerAs: 'vacancies'
      })
      .when('/vacancies/:vacancyId/edit', {
        templateUrl: 'views/edit_vacancy.html',
        controller: 'EditVacancyCtrl',
        controllerAs: 'vacancy'
      })
      .when('/employees', {
        templateUrl: 'views/employees.html',
        controller: 'EmployeesCtrl',
        controllerAs: 'employees'
      })
      .otherwise({
        redirectTo: '/'
      });
  });

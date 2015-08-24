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
      .when('/vacancies/:vacancyId', {
        templateUrl: 'views/show_vacancy.html',
        controller: 'ShowVacancyCtrl',
        controllerAs: 'vacancy'
      })
      .when('/vacancies/:vacancyId/edit', {
        templateUrl: 'views/edit_vacancy.html',
        controller: 'EditVacancyCtrl',
        controllerAs: 'editVacancy'
      })
      .when('/employees', {
        templateUrl: 'views/employees.html',
        controller: 'EmployeesCtrl',
        controllerAs: 'employees'
      })
      .when('/employees/:employeeId', {
        templateUrl: 'views/show_employee.html',
        controller: 'ShowEmployeeCtrl',
        controllerAs: 'showEmployee'
      })
      .when('/employees/:employeeId/edit', {
        templateUrl: 'views/edit_employee.html',
        controller: 'EditEmployeeCtrl',
        controllerAs: 'editEmployee'
      })
      .otherwise({
        redirectTo: '/'
      });
  });

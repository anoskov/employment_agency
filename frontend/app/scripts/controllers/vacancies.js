'use strict';

angular.module('employmentAgencyApp')
  .controller('VacanciesCtrl', function ($scope, Restangular, $modal) {
    this.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.alerts = [];
    $scope.closeAlert = function(index) {
      $scope.alerts.splice(index, 1);
    };

    var baseVacancies = Restangular.all('vacancies');
    baseVacancies.getList().then(function(vacancies) {
      $scope.allVacancies = vacancies;
    });

    $scope.animationsEnabled = true;

    $scope.addVacancy = function () {

      var modalInstance = $modal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'addVacancyModal.html',
        controller: 'VacancyModalCtrl',
        resolve: {
          vacancy: {}
        }
      });

      modalInstance.result.then(function (result) {
        $scope.alerts.push(result.alert);
        $scope.allVacancies.push(result.vacancy);
      });
    };

    $scope.deleteVacancy = function (id, index) {
      Restangular.one("vacancies", id).remove().then(function(response) {
        var alert = response;
        alert.type = "success";
        $scope.alerts.push(alert);
        $scope.allVacancies.splice(index, 1);
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
  .controller('VacancyModalCtrl', function (Restangular, $scope, $filter, $http, $modalInstance, vacancy) {

    $scope.modalAlerts = [];
    $scope.closeAlert = function (index) {
      $scope.modalAlerts.splice(index, 1);
    };

    $scope.loadSkills = function(query) {
      return $http.get('/api/v1/skills?query=' + query, { cache: true}).then(function(response) {
        var result = {};
        result.data = response.data.result;
        return result;
      });
    };

    $scope.vacancy = vacancy;

    $scope.submitVacancy = function () {
      $scope.vacancy.expiration_date = $filter('date')($scope.vacancy.expiration_date, "yyyy-MM-dd");
      $scope.vacancy.created_date = $filter('date')(new Date(), "yyyy-MM-dd");
      Restangular.all('vacancies').post($scope.vacancy).then(function(response) {
        var result = response;
        $scope.vacancy.id = result.id;
        result.type = "success";
        $scope.vacancy.skills = $scope.vacancy.skills_attributes;
        var alert = {msg: result.msg, errors: result.errors, type: 'success'};
        $modalInstance.close({vacancy: $scope.vacancy, alert: alert});
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

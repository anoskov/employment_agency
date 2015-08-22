'use strict';

angular.module('employmentAgencyApp')
  .controller('VacanciesCtrl', function ($scope, Restangular, $modal, $filter) {
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
        controller: 'ModalInstanceCtrl',
        resolve: {
          vacancy: {}
        }
      });

      modalInstance.result.then(function (vacancy) {
        vacancy.expiration_date = $filter('date')(vacancy.expiration_date, "yyyy-MM-dd");
        baseVacancies.post(vacancy).then(function(response) {
          var alert = response.data;
          alert.type = "success";
          $scope.alerts.push(alert);
          $scope.allVacancies.push(vacancy);
        }, function(response) {
          var alert = response.data.result;
          alert.type = "danger";
          $scope.alerts.push(alert);
        });
      });
    };

    $scope.deleteVacancy = function (id, index) {
      Restangular.one("vacancies", id).remove().then(function(response) {
        var alert = response.data;
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

    $scope.exp_date_opened = false;

    $scope.today = function() {
      $scope.dt = new Date();
    };
    $scope.today();

    $scope.dateOptions = {
      formatYear: 'yyyy',
      startingDay: 1
    };

    $scope.open = function($event) {
      $event.preventDefault();
      $event.stopPropagation();
    };

    $scope.clear = function () {
      $scope.dt = null;
    };

  })
  .controller('ModalInstanceCtrl', function (Restangular, $scope, $modalInstance, vacancy) {


    var baseSkills = Restangular.all('skills');
    baseSkills.getList().then(function(skills) {
      $scope.skills = skills
      });

    $scope.vacancy = vacancy;

    $scope.submitVacancy = function () {
      $modalInstance.close($scope.vacancy);
    };

    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };
  });

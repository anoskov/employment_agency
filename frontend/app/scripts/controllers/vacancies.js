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
        vacancy.created_date = $filter('date')(new Date(), "yyyy-MM-dd");
        vacancy.skills_attributes = vacancy.skills_attributes.concat(vacancy.new_skills);
        vacancy.skills = vacancy.skills_attributes;
        baseVacancies.post(vacancy).then(function(response) {
          var result = response;
          console.log(result);
          vacancy.id = result.id;
          result.type = "success";
          $scope.alerts.push(result);
          $scope.allVacancies.push(vacancy);
        }, function(response) {
          var result = response.data.result;
          result.type = "danger";
          $scope.alerts.push(result);
        });
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

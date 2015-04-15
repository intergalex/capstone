(function() {
  "use strict";

  angular.module("app").controller("happeningsCtrl", function($scope, $http, $sce){

  $scope.show = false;
  $scope.happenings = [];

  $scope.fetchData = function() {
    $http.get("/api/v1/happenings.json").then(function(response) {
      $scope.happenings = response.data["happenings"];
    });
  };

  $scope.toggleDescriptionVisible = function(happening) {

        happening.descriptionVisible = !happening.descriptionVisible;

      };

  $scope.makeTrust = function(html){
        return $sce.trustAsHtml(html);
      };

  $scope.addHappening = function(newName, newAddress, newTime, newDescription) {
    // $scope.$apply();

    var happening = {
      name: newName,
      address: newAddress,
      start_time: $scope.happeningTime,
      description: newDescription,
    };
    console.log(newTime);

    $http.post('api/v1/happenings.json', happening).then(function(response) {
        $scope.happenings.push(happening);
        $scope.happeningName = null;
        $scope.happeningAddress = null;
        $scope.happeningTime = null;
        $scope.happeningDescription = null;
      }, function(error) {
        $scope.errors = error.data.errors;
      });  
  
  };

  window.scope = $scope; 

  });

}());
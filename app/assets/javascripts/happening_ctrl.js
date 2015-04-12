(function() {
  "use strict";

  angular.module("app").controller("happeningsCtrl", function($scope, $http, $sce){

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
  // $scope.addHappening = function(newFirstName, newLastName, newBio) {
  //   var happening = {
  //     name: newName,
  //     address: newAddress,
  //     description: newDescription
  //     human_time: newStartTime 
  //   };

  //   $http.post('api/v1/happenings.json', happeing).then(function(response) {
  //       $scope.happenings.push(character);
  //       $scope.newName = null;
  //       $scope.newAddress = null;
  //       $scope.newDescription = null;
  //       $scope.newStartTime = null;
  //     }, function(error) {
  //       $scope.errors = error.data.errors;
  //     });  
  
  // };

  window.scope = $scope; 

  });

}());
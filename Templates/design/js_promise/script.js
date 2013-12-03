// Chaining promises
// http://docs.angularjs.org/api/ng.$q

var PromiseApp = angular.module('promiseApp', []);

function SeqCtrl($scope, $http) {
  $scope.api13Ret = "";
  $scope.api12Ret = "";
  $scope.api11Ret = "";
  
  $http.get("/api/3").then(function(rsp) {
    $scope.api13Ret = rsp.data.ret;
    return $http.get("/api/2");
  }).then(function(rsp) {
    $scope.api12Ret = rsp.data.ret;
    return $http.get("/api/1");
  }).then(function(rsp) {
    $scope.api11Ret = rsp.data.ret;
  });
}
SeqCtrl.$inject = ["$scope", "$http"];

function JoinCtrl($scope, $http, $q) {
  $scope.api24Ret = "";
  $scope.api23Ret = "";
  $scope.api22Ret = "";
  $scope.api21Ret = "";
  
  var api21 = $http.get("/api/1");
  var api22 = $http.get("/api/2");
  var api23 = $http.get("/api/3");
  $q.all([api21, api22, api23]).then(function(rspList) {
    $scope.api23Ret = rspList[2].data.ret;
    $scope.api22Ret = rspList[1].data.ret;
    $scope.api21Ret = rspList[0].data.ret;
    return $http.get("/api/4");
  }).then(function(rsp) {
    $scope.api24Ret = rsp.data.ret;
  });
}
JoinCtrl.$inject = ["$scope", "$http", "$q"];


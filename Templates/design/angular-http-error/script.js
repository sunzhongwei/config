var app = angular.module('app', []);

app.controller("ContactsCtrl", ["$scope", "$http", "$log", function($scope, $http, $log) {
  $log.info("init"); 

  $http({method: 'GET', url: '/contacts'}).
    success(function(data, status, headers, config) {
      // this callback will be called asynchronously
      // when the response is available
      // http://docs.angularjs.org/api/ng/service/$http
      // A response status code between 200 and 299 is considered a success 
      // status and will result in the success callback being called. Note 
      // that if the response is a redirect, XMLHttpRequest will 
      // transparently follow it, meaning that the error callback will not 
      // be called for such responses.
      $scope.contacts = data.data;
    }).
    error(function(data, status, headers, config) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
    });

  $http({method: 'GET', url: '/contacts-500'}).
    success(function(data, status, headers, config) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.contacts500 = data.data;
    }).
    error(function(data, status, headers, config) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
      $log.info("status code is: " + status);
      $scope.msg500 = "Fail to get response with status code: " + status;
    });

  $http({method: 'GET', url: '/contacts-ret-code'}).
    success(function(data, status, headers, config) {
      // this callback will be called asynchronously
      // when the response is available
      var retCode = data.ecode;
      if (retCode === 0) {
        $scope.contactsRetCode = data.data;
      } else {
        $scope.msgRetCode = "error happens with return code: " + retCode;
      }
    }).
    error(function(data, status, headers, config) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
      $log.info("status code is: " + status);
      $scope.msgRetCode = "Fail to get response with status code: " + status;
    });

}]);

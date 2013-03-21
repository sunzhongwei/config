'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('myApp.services', ["ngResource"]).

  value('version', '0.1').
  
  factory("Todo", ["$resource", function($resource) {
    return $resource("/todos/:todoId", {todoId: "@id"}, {
      query: {method: "GET", isArray: false},
      save: {method: "POST", params: {content: "@content"}},
      update: {method: "PUT", params: {content: "@content"}},
      get: {method: "GET", params: {}},
      delete: {method: "DELETE", params: {}}
    });
  }]);

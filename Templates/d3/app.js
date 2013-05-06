'use strict';

// create module for custom directives
var d3DemoApp = angular.module('d3DemoApp', []);

// controller business logic
d3DemoApp.controller('AppCtrl', function AppCtrl($scope) {
  $scope.name = "Zhongwei";
});

d3DemoApp.directive("myDirective", function (/* dependencies */) {
  return {
  	restrict: "E",  // Element name: <my-directive></my-directive>
  	link: function (scope, element, sttrs) {
  	  var width = 500;
  	  var height = 500;
  	  var svg = d3.select("body")
  	  			  .append("svg")
  	  			  .attr("width", width)
  	  			  .attr("height", height);
  	  svg.append("rect")
  	     .attr("x", 0)
  	     .attr("y", 0)
  	     .attr("width", 20)
  	     .attr("height", 100);
  	}
  };
});
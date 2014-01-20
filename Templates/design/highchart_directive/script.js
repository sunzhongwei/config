var highchartApp = angular.module('highchartApp', []);

highchartApp.controller("mainController", ["$scope", "$timeout", function($scope, $timeout) {
  $scope.staticAreaChart = {
    "title": {
      "text": "tasks in queue waiting for handling"
    },
    "subtitle": {
      "text": "Source: <a href=\"http://www.sunzhongwei.com\">大象笔记</a>"
    },
    credits: {
      enabled: false
    },
    "xAxis": {
      "type": "datetime"
    },
    "yAxis": {
      title: {
        text: '剩余任务数量',
        margin: 20
      },
      labels: {
        formatter: function() {
          //return this.value / 1000 +'k';
          return this.value;
        }
      }
    },
    "tooltip": {},
    "series": [
      {
        "name": "redis 队列",
        "data": [
          [1343038130, 53],
          [1343058190, 45],
          [1343088250, 99],
          [1343188250, 99]
        ]
      },
      {
        "name": "mysql 队列",
        "data": [
          [1343038130, 11],
          [1343058190, 82],
          [1343088250, 33],
          [1343188250, 99]
        ]
      }
    ]
  };

  $scope.dynamicAreaChart = {
    "title": {
      "text": "tasks in queue waiting for handling"
    },
    "subtitle": {
      "text": "Source: <a href=\"http://www.sunzhongwei.com\">大象笔记</a>"
    },
    credits: {
      enabled: false
    },
    "xAxis": {
      "type": "datetime"
    },
    "yAxis": {
      title: {
        text: '剩余任务数量',
        margin: 20
      },
      labels: {
        formatter: function() {
          //return this.value / 1000 +'k';
          return this.value;
        }
      }
    },
    "tooltip": {},
    "series": []
  };

  function fetchGraphData() {
    var data = {
      "name": "mysql 队列",
      "data": [
        [1343038130, 11],
        [1343058190, 82],
        [1343088250, 33],
        [1343188250, 99]
      ]
    }
    var newChart = new Object();
    angular.copy($scope.dynamicAreaChart, newChart);
    newChart.series = [data];
    $scope.dynamicAreaChart = newChart;
  }

  var timer;
  function intervalFunc() {
    timer = $timeout(function() {
      fetchGraphData();
      intervalFunc();
    }, 3000);
  }

  fetchGraphData();   // not wait
  intervalFunc();

  function cancelIntervalFunc() {
    $timeout.cancel(timer);
  }

  $scope.$on('$destroy', cancelIntervalFunc);
}]);

highchartApp.directive('chart', function () {
  return {
    restrict: 'E',
    template: '<div></div>',
    scope: {
        chartData: "=value"
    },
    transclude: true,
    replace: true,

    link: function (scope, element, attrs) {
      var chartsDefaults = {
        chart: {
          renderTo: element[0],
          type: attrs.type || null,
          height: attrs.height || null,
          width: attrs.width || null
        }
      };
      
      //Update when charts data changes
      scope.$watch(function() { return scope.chartData; }, function(value) {
        if(!value) return;
          // We need deep copy in order to NOT override original chart object.
          // This allows us to override chart data member and still the keep
          // our original renderTo will be the same
          var newSettings = {};
          angular.extend(newSettings, chartsDefaults, scope.chartData);
          var chart = new Highcharts.Chart(newSettings);
      });
    }
  };

});

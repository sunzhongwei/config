'use strict';

/* Controllers */


function MyCtrl1() {}
MyCtrl1.$inject = [];


function MyCtrl2() {
}
MyCtrl2.$inject = [];


function TodosCtrl($scope, Todo, $log) {
  Todo.query(
    {},   // params
    function (data) {   // succcess
      if (data.ret === 0) {
        $scope.todos = data.data
      } else {
        $log.info("fails to get data, ret: " + data.ret);
        alert("数据获取失败，服务端可耻的出错了");
        $scope.todos = [];
      }
    },
    function (data) {   // failture
      $log.info("http error");
      alert("数据获取失败，请确认是否是网络问题");
    }
  ); 

  $scope.addTodo = function() {
    var newTodo = new Todo({content: $scope.todoContent}); 
    newTodo.$save(
      {},   // params
      function (data) {   // succcess
        if (data.ret === 0) {
          $scope.todos.push({id: data.data.id, content: $scope.todoContent});
          $scope.todoContent = "";
        } else {
          $log.info("fails to get data, ret: " + data.ret);
          alert("提交失败，服务端可耻的出错了");
        }
      },
      function (data) {   // failture
        $log.info("http error");
        alert("提交失败，请确认是否是网络问题");
      }
    );
  };

  $scope.delectTodo = function(index) {
    var todo = $scope.todos[index];
    Todo.delete(
      {todoId: todo.id},   // params
      function (data) {   // succcess
        if (data.ret === 0) {
          alert("删除成功");
          $scope.todos.splice(index, 1);
        } else {
          alert("删除失败，服务端可耻的出错了");
        }
      },
      function (data) {   // failture
        alert("删除失败，请确认是否是网络问题");
      }
    );
  };

}; 
TodosCtrl.$inject = ["$scope", "Todo", "$log"];



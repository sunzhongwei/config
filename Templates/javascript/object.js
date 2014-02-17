/**
 * $ node object.js
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Working_with_Objects
 */

console.log("start test");


/**
 * create object 
 */
console.log("--------- create object -----------");

var myCar = new Object();
myCar.make = "Ford";
myCar.year = 1969;
// Properties can also be accessed or set using a bracket notation.
myCar["color"] = "black";   

// {make: 'Ford', year: 1969, color: 'black'}
console.log(myCar);   


/**
 * 使用中括号，来获取、设置属性的场景：
 * - 属性名是变量时
 * - 属性名不能转换为一个合法的变量名时，例如，包含空格，数字开头，特殊字符等,空字符串
 */
console.log("--------- bracket notation -----------");

var zhongwei = new Object(); 
zhongwei[""] = "empty string"
zhongwei["last name"] = "Sun"
zhongwei["8g"] = "8g"

// { '': 'empty string', 'last name': 'Sun', '8g': '8g' }
console.log(zhongwei);  
var p = "last name";
console.log(zhongwei[p]);


/**
 * 遍历所有属性的方法
 * - for ... in 
 * - Object.keys(o)   // ie version >= 9
 * - Object.getOwnPropertyNames(o)    // ie version >= 9
 */
console.log("--------- enumerating all properties of an object -----------");

console.log("method 1: for ... in");
for (var key in myCar) {
  if (myCar.hasOwnProperty(key)) {
    // 为了避免将继承来的属性也打印出来，所以需要使用 hasOwnProperty 进行限定
    console.log(key + ": " + myCar[key]);
  }
}

console.log("method 2: Object.keys(o)");
console.log(Object.keys(myCar));


/**
 * 分组
 */
console.log("------- grouping --------");

items = [
  "host1/ip1/metric1",
  "host3/ip1/metric2",
  "host2/ip1/metric2",
  "host1/ip2/metric1",
  "host2/ip1/metric3",
  "host3/ip1/metric1",
  "host1/ip3/metric1",
  "host2/ip1/metric1",
  "host3/ip1/metric3"
];

var group = new Object();
for (i = 0; i < items.length; i++) {
  var keys = items[i].split("/");
  var host = keys[0];
  var ip = keys[1];
  var metric = keys[2];

  if (!group.hasOwnProperty(host)) {
    group[host] = new Object();
    group[host][ip] = [metric];
  } else {
    if (!group[host].hasOwnProperty(ip)) {
      group[host][ip] = [metric];
    } else {
      group[host][ip].push(metric);
    }
  }
}

// { host1: { ip1: [ 'metric1' ], ip2: [ 'metric1' ], ip3: [ 'metric1' ] },
//   host3: { ip1: [ 'metric2', 'metric1', 'metric3' ] },
//   host2: { ip1: [ 'metric2', 'metric3', 'metric1' ] } }
console.log(group);




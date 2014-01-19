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


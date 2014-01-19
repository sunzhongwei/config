/**
 * $ node array.js
 */

console.log("start test");

/**
 * create Array 3 ways
 */
console.log("------ create array -------");

var arr1 = new Array(1, 2, 3);
var arr2 = Array(4, 5, 6);
var arr3 = [7, 8, 9];
console.log(arr1);
console.log(arr2);
console.log(arr3);
console.log("length is: " + arr1.length);


/**
 * Iterating over arrays
 */
console.log("---------- Iterating over arrays ------------");

var colors = ["red", "blue", "green"];

console.log("method 1: for ... loop");
for (var i = 0; i < colors.length; i++) {
  console.log(colors[i]);
}

console.log("method 2: forEach, ie does not support this way.");
colors.forEach(function(color) {
  console.log(color);
});

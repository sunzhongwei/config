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


/**
 * slice
 */
console.log("---------- slice ---------------");
var nums = [1, 2, 3, 4, 5];
console.log("slice 返回 array, 而 [*] 返回元素");
console.log(nums.slice(1));
console.log(nums.slice(1, 3));
console.log(nums.slice(3, 4));

console.log(nums[4]);


/**
 * remove item by index
 */
console.log("-------- remove item by index ----------")
var nums = [11, 12, 13, 14, 15];
console.log("before removing, nums is:")
console.log(nums)
nums.splice(2, 1)
console.log("after removing, nums is:")
console.log(nums)


/**
 * sort array
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort
 */
console.log("-------------- sort array ---------------");

var orgArr = [
  [5788.0,1390360334],
  [181.0,1390360407],
  [25896.0,1390360418],
  [10059.0,1390360419],
  [1356.0,1390360420],
  [12854.0,1390360420],
  [25212.0,1390360422],
  [12330.0,1390360423],
  [961.0,1390360423],
  [31788.0,1390360423],
  [6192.0,1390360424],
  [7501.0,1390360425],
  [16101.0,1390360426],
  [23369.0,1390360426],
  [14860.0,1390360427]
];

console.log("original array:");
console.log(orgArr);
orgArr.sort(function(a, b) {
  // 注意， 不是 return a[1] > b[1];
  return a[1] - b[1];
});
console.log("sorted array");
console.log(orgArr);


/**
 * Check if array element exists
 */
console.log("------- Check if array element exists -----------");

var names = ["zhongwei", "test"];
var name = "zhongwei";

if (names.indexOf(name) == -1) {
  console.log(name + " is not in array " + names);
} else {
  console.log(name + " is in array " + names);
}


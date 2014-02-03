/**
 * $ node datetime.js
 */

console.log("Start");


/**
 * Current time
 */
var now = new Date();
console.log("Current time is: " + now);   // Thu Jan 30 2014 15:53:10 
                                          // GMT+0800 (CST)


/**
 * Format
 */
var year = now.getFullYear();
console.log("year: " + year);

var month = now.getMonth() + 1;   // Note: month indexes from 0
console.log("month: " + month);

var day = now.getDate();
console.log("day: " + day);   

var weekDay = now.getDay();
console.log("week day: " + weekDay);    // Sunday is 0

var hour = now.getHours();
console.log("hour: " + hour);

console.log("Current date: " + now.toLocaleDateString());
console.log("Current time: " + now.toLocaleTimeString());


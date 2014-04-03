/**
 *  $ node string.js
 */


console.log("Start");


/**
 * multi line 
 */
var s = "This is one-line string \
written on multi line";
console.log(s);


/**
 * substring
 */
console.log("Char at index 1: " + s.charAt(1));
console.log("Last char: " + s.charAt(s.length - 1));
console.log("The 2nd, 3rd and 4th chars: " + s.slice(1, 4));


/**
 * split
 */
console.log("------------ split ------------");
var s = "1/2/3";
var slices = s.split("/");
console.log(slices);

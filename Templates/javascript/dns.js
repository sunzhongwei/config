function isValidIP(ip) {
  var expression = /(^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$)/;
  return expression.test(ip);
};

console.log(isValidIP('127.0.0.1'));
console.log(isValidIP('0.0.1'));


function isValidDomain(domain) {
  var expression = /^((?:(?:(?:\w[\.\-\+]?)*)\w)+)((?:(?:(?:\w[\.\-\+]?){0,62})\w)+)\.(\w{2,6})$/;
  return expression.test(domain);
}

console.log(isValidDomain("paobujie.com"));
console.log(isValidDomain("paobujie"));

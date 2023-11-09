
let validateJwt = require('./validateJwt');

// Retrieve token from the command line.  In a webapp, this will be provided in the Authorization: Bearer header
if (process.argv.length < 3) {
  console.log("Please provide JWT as command line argument");  
  return;
} 

var token = process.argv[2];
var result = validateJwt(token); 
result.then( f => console.log(f) );

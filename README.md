A simple example of how we can validate a JWT using NodeJS.

The following packages are required:

 1. jsonwebtoken - for decoding and verifying JWTs
 2. jwk-to-pem - needed because google provides keys in jwk format, but jsonwebtoken expects keys in pem format
 3. node-fetch@2 - just wanted the convenience of using fetch API.  Need the version 2 branch cause the new v3.x 
only works with ESM modules.

# How to run

The main goal of is repository is to illustrate the use of validateJWT function, found inside validateJwt.js.
I provide two ways to test validateJwt function:

Assuming you have a JWT stored in the variable Google_JWT:

```
$ npm install
$ node cli.js ${Google_JWT}

```

Or call it as a web API:

```
$ npm install
$ node app.js & # run the app in the background
$ curl localhost:3000/verify?jwt=${Google_JWT}
```


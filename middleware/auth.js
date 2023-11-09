const jwt = require("jsonwebtoken");
const jwkToPem = require("jwk-to-pem");

async function validateJwt(req, res, next) {
  const tokenString = req.headers["authorization"].split(" ");

  const token = tokenString[1];

  // get me the kid
  const decoded = jwt.decode(token, { complete: true });
  let kid = decoded.header["kid"];
  console.log("DECODED", kid);

  const data = await fetch("https://www.googleapis.com/oauth2/v3/certs");
  const certs = await data.json();
  console.log("CERTS", certs);

  let key = certs.keys.filter((c) => c.kid == kid);

  let pem = jwkToPem(key[0]);

  try {
    let result = await jwt.verify(token, pem);
    console.log("RESULT", result);
    next();
  } catch (e) {
    res.status(401).send("Unauthorized");
  }
}

module.exports = validateJwt;

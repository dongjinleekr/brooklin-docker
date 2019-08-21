#!/bin/sh -e

FILENAME="brooklin-${BROOKLIN_VERSION}.tgz"

URL="https://github.com/linkedin/brooklin/releases/download/${BROOKLIN_VERSION}/brooklin-${BROOKLIN_VERSION}.tgz"

echo "Downloading Brooklin from ${URL}"
wget "${URL}" -O "/tmp/${FILENAME}"


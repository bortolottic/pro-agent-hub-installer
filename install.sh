#!/usr/bin/env bash

set -e

REPO="bortolottic/pro-agent-hub-installer"

VERSION="${1:-latest}"

if [ "$VERSION" = "latest" ]; then
  VERSION=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep tag_name \
  | cut -d '"' -f4)
fi

PACKAGE="pro-agent-hub-${VERSION}.zip"

URL="https://github.com/$REPO/releases/download/${VERSION}/${PACKAGE}"

curl -L $URL -o package.zip

unzip package.zip

cd pro-agent-hub

chmod +x deploy_production.sh

./deploy_production.sh
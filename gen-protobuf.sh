#!/usr/bin/env bash

set -e

rm -rf message avatica-tmp

export AVATICA_VER="rel/avatica-1.10.0"

mkdir -p avatica-tmp
pushd avatica-tmp &> /dev/null

git init
git remote add origin https://github.com/apache/calcite-avatica.git
git config core.sparsecheckout true
echo "core/src/main/protobuf/*" >> .git/info/sparse-checkout

git fetch --depth=1 origin $AVATICA_VER
git checkout FETCH_HEAD

popd &> /dev/null

mkdir -p message

protoc --proto_path=avatica-tmp/core/src/main/protobuf --go_out=import_path=message:message avatica-tmp/core/src/main/protobuf/*.proto

rm -rf avatica-tmp

echo -e "\nProtobufs generated!"

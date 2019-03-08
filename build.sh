#! /bin/bash

if [[ "$1" == "" ]]; then
  TAG=latest
else
  TAG=$1
fi

find . -name ".repo" | while read repo
do
  FULLTAG=$(cat $repo | tr -d '[:space:]'):$TAG
  pushd `dirname $repo` >/dev/null
  docker build -t $FULLTAG .
  popd >/dev/null
done

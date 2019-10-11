#!/bin/bash

set -e

if [ -z ${MIRROR_PATH+x} ]; then
  export MIRROR_PATH="$HOME/.mirror"
fi

export usage=$(echo "usage:
    mirror file url
    mirror repo url [branch | tag | commit]
")

die () {
  echo >&2 "$@"
  exit 1
}

mirrorFile() {
  [ "$#" -eq 1 ] || die "$usage"
  export url=$1
  
  mkdir -p "$MIRROR_PATH/file"
  export file="$MIRROR_PATH/file/$(basename $url)-$(echo $url | md5sum | cut -f1 -d" ")"
  
  if [ ! -f $file ]; then
    curl "$url" --silent > $file
  fi
  
  cat $file
}

mirrorRepo() {
  [ "$#" -ge 1 ] || die "$usage"
  export url=$1
  if [[ $url =~ '[_a-zA-Z0-9]+/[_a-zA-Z0-9]+' ]]; then
    export url="https://github.com/$url"
  fi
  
  if [ "$#" -ge 2 ]; then
    export branchOrTag=$2
  else
    export branchOrTag="master"
  fi
  
  mkdir -p "$MIRROR_PATH/repo"
  export directory="$MIRROR_PATH/repo/$(basename $url)-$branchOrTag-$(echo $url $branchOrTag | md5sum | cut -f1 -d" ")"
  
  if [ ! -d $directory ]; then
    git clone -b "$branchOrTag" --single-branch --recurse-submodules --depth 1 "$url" "$directory" -q
  fi
  
  echo $directory
}

if [ "$1" == "file" ]; then
  mirrorFile ${@:2}
  elif [ "$1" == "repo" ]; then
  mirrorRepo ${@:2}
  elif [ -x "$(command -v mirror-$1)" ]; then
  "mirror-$1" $@
else
  echo "$usage"
fi
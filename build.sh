#!/bin/bash

[[ -z $1 ]] || [[ -z $2 ]] && { 
    echo "Parameter 'ImageType' or 'ImageName' is empty."
    echo "USAGE: build.sh [base|foscos] (all|ImageName)"
    exit 1 
}

if [ -d $1 ] ; then
  if [[ -d $1/$2 && $2!="all" ]] ; then
    cd $1; docker-compose build -d $2
  else
    cd $1; docker-compose build
  fi
fi 
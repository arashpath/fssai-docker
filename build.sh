#!/bin/bash

[[ -z $1 ]] || [[ -z $2 ]] && { 
    echo "Parameter 'ImageType' or 'ImageName' is empty."
    echo "USAGE: build.sh [base|foscos] (all|ImageName)"
    exit 1 
}

if [ -d $1 ] ; then
  if [[ -d $1/$2 && $2!="all" ]] ; then
    docker-compose -f $1/docker-compose.yml build -d $2
  elif
    docker-compose -f $1/docker-compose.yml build
  fi
fi 
#!/bin/bash
ENV=$RACK_ENV
export uid=$UID
export gid=`id -g`

if [ "$ENV" = 'production' ]; then
  docker-compose run --entrypoint=$entrypoint -e RACK_ENV=$ENV web s
  exit 0
fi

entrypoint=docker/run.sh
if [ "$1" = 'up' ]; then
  docker-compose up
elif [ "$1" = 'rspec' ]; then
  docker-compose run --entrypoint=$entrypoint -e RACK_ENV=test web $@
elif [ "$1" = 'spring' ]; then
  docker-compose run -u "$uid:$gid" --entrypoint=$entrypoint -d spring spring
elif [ "$1" = 's' ]; then
  docker-compose run -p 3000:3000 -u "" --entrypoint=$entrypoint -e RACK_ENV=development web s
else
  docker-compose run -u "$uid:$gid" --entrypoint=$entrypoint -e RACK_ENV=development web $@
fi

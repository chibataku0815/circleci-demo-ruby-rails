#!/bin/ash

if [ "$RACK_ENV" = 'development' -o "$RACK_ENV" = 'test' -o "$RACK_ENV" = '' ]; then
  if [ $# -eq 0 ]; then
    bundle exec rails -h
  elif [ $1 = 'rspec' ]; then
    bundle exec $@
  elif [ $1 = 'spring' ]; then
    bundle exec spring binstub --all
    #bundle exec spring binstub --remove --all
    bin/spring server
  else
    time bundle exec rails $@
  fi
  exit 0
fi

bundle exec unicorn -c config/unicorn.rb -E $RACK_ENV

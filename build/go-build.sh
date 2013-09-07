#!/bin/bash -l

rvm use 1.9.3@appointment --create --fuzzy
bundle update
[ -d rspec ] && rm -rf rspec
COVERAGE=true bundle exec rspec --out rspec/rspec.xml --format html --out rspec/rspec.html

[ -d cucumber ] && rm -rf cucumber
mkdir cucumber
COVERAGE=true bundle exec cucumber --format html --out cucumber/cucumber.html --no-source

exit $?

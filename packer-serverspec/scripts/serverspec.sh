#!/bin/bash
export PATH=/opt/chef/embedded/bin:$PATH
cd /tmp/tests
bundle install --path=vendor
bundle exec rake spec

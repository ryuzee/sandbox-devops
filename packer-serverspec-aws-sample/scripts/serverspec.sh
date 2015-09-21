#!/bin/bash
cd /tmp/tests
sudo sh -c "PATH=/opt/chef/embedded/bin:$PATH; bundle install --path=vendor"
sudo sh -c "PATH=/opt/chef/embedded/bin:$PATH; bundle exec rake spec"

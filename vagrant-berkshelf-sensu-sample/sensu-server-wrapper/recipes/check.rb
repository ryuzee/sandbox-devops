#
# Cookbook Name:: sensu-server-wrapper::check 
# Recipe:: default
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# All rights reserved - Do Not Redistribute
#
template "/etc/sensu/conf.d/check_cron.json" do
  owner "root"
  mode  0755
  source "check_cron.json.erb"
end

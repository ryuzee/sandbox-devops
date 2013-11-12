#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
sensu_client node.myapp.name do
  address node.myapp.ipaddress
  subscriptions node.myapp.roles + ["all"]
end

#
# Cookbook Name:: sensu-client-wrapper 
# Recipe:: default
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# All rights reserved - Do Not Redistribute
#
include_recipe "sensu::default"

sensu_client node["sensu-client-wrapper"]["name"] do
  address node["sensu-client-wrapper"]["ipaddress"]
  subscriptions node["sensu-client-wrapper"]["roles"] + ["all"]
end

execute "chmod 644 /etc/sensu/conf.d/client.json" do
  action :run
end

include_recipe "sensu::client_service"

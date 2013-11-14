#
# Cookbook Name:: acme_sensu_client
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "sensu::default"

sensu_client node.acme_sensu_client.name do
  address node.acme_sensu_client.ipaddress
  subscriptions node.acme_sensu_client.roles + ["all"]
end

execute "chmod 644 /etc/sensu/conf.d/client.json" do
  action :run
end

include_recipe "sensu::client_service"

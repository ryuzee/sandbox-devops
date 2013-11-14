#
# Cookbook Name:: sensu-server-wrapper 
# Recipe:: default
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# All rights reserved - Do Not Redistribute
#
include_recipe "iptables"
iptables_rule "http_8080"
iptables_rule "rabbitmq"
iptables_rule "ssh"

include_recipe "yum::epel"
package "erlang" do
  action :install
#  options "--disablerepo=\* --enablerepo=epel"
  options "--enablerepo=epel"
end

include_recipe "sensu::default"
include_recipe "sensu::rabbitmq"
include_recipe "sensu::redis"
include_recipe "sensu::api_service"
include_recipe "sensu::dashboard_service"
include_recipe "sensu::server_service"

#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "iptables"
iptables_rule "http_8080"
iptables_rule "rabbitmq"
iptables_rule "ssh"

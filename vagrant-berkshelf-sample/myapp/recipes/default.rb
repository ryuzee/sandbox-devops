#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
iptables_rule "http"
iptables_rule "ssh"

package "httpd" do
  action :install
end

package "mod_php" do
  action :install
end

package "php-mbstring" do
  action :install
end

service "httpd" do
  action :start
end

require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'
 
Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")
 
rest = Chef::REST.new(::Chef::Config[:chef_server_url])

nodes = rest.get_rest("/nodes/")
 
nodes.keys.each do |node_name|
  print "#{node_name}\n"
end

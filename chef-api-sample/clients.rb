require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'
require 'pp'

Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")

url = "/clients"
rest = Chef::REST.new(::Chef::Config[:chef_server_url])
clients = rest.get_rest(url)

clients.each do |k,v|
  puts k 
end


require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'

Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")

url = "/environments/_default/cookbooks?num_versions=1"
rest = Chef::REST.new(::Chef::Config[:chef_server_url])
cookbooks = rest.get_rest(url)

cookbooks.each do |k,v|
  puts "#{k} #{v["versions"][0]["version"]}\n"
end

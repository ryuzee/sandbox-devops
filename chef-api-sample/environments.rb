require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'
require 'chef/environment'
require 'pp'
 
Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")
 
## Environment の取得
Chef::Environment.list.each do |k,v|
  print "#{k} = #{v}\n"
end

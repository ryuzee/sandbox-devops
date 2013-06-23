require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'
 
Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")
 
# Get Node
Chef::Node.list(true).each do |node_array|
  begin
    node = node_array[1]
    print "[#{node.name}]\n"
    print "\t#{node[:fqdn]}\n"
    print "\t#{node[:ipaddress]}\n"
    print "\t#{node[:kernel][:machine]}\n"
    print "\t#{node[:kernel][:release]}\n"
    print "\t#{node[:kernel][:version]}\n"
    print "\t#{node[:kernel][:os]}\n"
    print "\t#{node[:platform]}\n"
    print "\t#{node[:platform_version]}\n"
    print "\t#{node[:uptime]}\n"
    print "\t#{node.chef_environment}\n"
    print "\t#{node.run_list.roles}\n"
    print "\t#{node[:languages][:ruby][:version]}\n"
    print "\t#{node[:recipes]}\n"
    print "\t#{node[:chef_packages]}\n"
    begin
      print "\t#{node[:languages][:php][:version]}\n"
    rescue
      print "\tPHP is not installed\n"
    end
  rescue
    print "\tCan not retrieve node information\n"
  end
end


require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'
require 'pp'
require 'spreadsheet'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet::Workbook.new
sheet = book.create_worksheet(:name => "nodes")
 
Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")
 
row = 0
Chef::Node.list(true).each do |node_array|
  begin
    node = node_array[1]
    begin
      php_version = node[:languages][:php][:version]
    rescue
      php_version = ""
    end
    sheet.row(row).replace [
      "#{node.name}",
      "#{node[:fqdn]}",
      "#{node[:ipaddress]}",
      "#{node[:kernel][:machine]}",
      "#{node[:kernel][:release]}",
      "#{node[:kernel][:version]}",
      "#{node[:kernel][:os]}",
      "#{node[:platform]}",
      "#{node[:platform_version]}",
      "#{node[:uptime]}",
      "#{node.chef_environment}",
      "#{node.run_list.roles}",
      "#{node[:languages][:ruby][:version]}",
      "#{node[:recipes]}",
      "#{node[:chef_packages]}",
      php_version
    ]
    row = row + 1
  rescue
  end
end

book.write "nodes.xls"

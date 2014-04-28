require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'
require 'chef/node'
require 'pp'
require 'spreadsheet'
require 'json'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet::Workbook.new
sheet = book.create_worksheet(:name => "nodes")

class ColorBorderFormat < Spreadsheet::Format
  def initialize
    self.border = :thin 
    super :top_color    => :black, 
          :bottom_color => :black,
          :left_color   => :black, 
          :right_color  => :black
  end
end
 
Chef::Config.from_file("#{ENV['HOME']}/.chef/knife.rb")
 
row = 0
sheet.row(row).replace [
  "nodename",
  "fqdn",
  "ipaddress",
  "machine",
  "release",
  "version",
  "os",
  "platform",
  "platform_version",
  "uptime",
  "chef_environment",
  "run_list.roles",
  "ruby_version",
  "chef_packages",
  "php_version"
]
sheet.row(0).default_format = ColorBorderFormat.new
row = row + 1

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
      "#{node[:chef_packages]}",
      php_version
    ]
    sheet.row(row).default_format = ColorBorderFormat.new
    row = row + 1
    node[:recipes].sort.each do |c|
      sheet.row(row).replace [
        "",
        "",
        "",
        "#{c}"
      ]
      sheet.row(row).default_format = ColorBorderFormat.new
      row = row + 1
    end
  rescue
  end
end

book.write "nodes.xls"

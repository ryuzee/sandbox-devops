#!ruby

require 'rubygems'
require 'chef/rest'
require 'chef/search/query'

Chef::Config.from_file(File.expand_path("~/.chef/knife.rb"))
query = Chef::Search::Query.new
nodes = query.search('node', 'roles:web AND chef_environment:production').first rescue []

puts nodes.map(&:name).join("\n")

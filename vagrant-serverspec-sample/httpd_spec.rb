require 'serverspec'
require 'pathname'
require 'net/ssh'

include SpecInfra::Helper::Ssh
include SpecInfra::Helper::DetectOS

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
    it { should be_enabled }
end

describe service('httpd') do
    it { should be_running }
end

describe port(80) do
    it { should be_listening }
end

describe file('/var/www/html/index.html') do
    it { should be_file }
end


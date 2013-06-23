%w{httpd}.each do |pkg|
  package pkg do
    action :install
  end
end

service "httpd" do
  supports :restart => true, :reload => true
  action :enable
end

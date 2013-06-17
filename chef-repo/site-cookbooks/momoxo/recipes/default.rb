%w{php php-gd php-mbstring php-mysql mysql-server httpd git mysql-server}.each do |pkg|
  package pkg do
    action :install
  end
end

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end

service "iptables" do
  action [ :disable, :stop ]
end

template "php.ini" do
  path "/etc/php.ini"
  source "php.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[httpd]'
end

template "httpd.conf" do
  path "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[httpd]'
end

directory "/var/www/html/momoxo" do
  owner "apache"
  group "apache"
  mode "0755"
  action :create
end

git "/var/www/html/momoxo" do
  repository "git://github.com/momoxo/v1"
  reference "master"
  action :checkout
  user "apache"
  group "apache"
end

execute "create momoxo database" do
  command "mysql -u root -e 'create database momoxo charset=utf8'"

  not_if "mysql -u root -e 'show databases;' | grep momoxo"
end

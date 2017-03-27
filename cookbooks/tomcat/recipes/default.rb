# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
download_file = '#{node[:tc][:download_url]}'

package 'unzip' do
  action :install
end

remote_file '/home/user/tomcat.zip' do
  source 'https://s3.amazonaws.com/s-bu/apache-tomcat-7.0.76.zip'
  owner 'root'
  mode '0755'
  action :create
end

execute 'unzip' do
  user 'root'
  cwd '/home/user/'
  action :run
  command 'unzip tomcat.zip'
  not_if { ::File.directory?('/home/user/apache*') }
end

execute 'move' do
  user 'root'
  cwd '/home/user/'
  action :run
  command 'mv apache* tomcat'
  not_if { ::File.directory?('/home/user/tomcat/') }
end

package 'java' do
  action :install
end

#
# Cookbook:: maven
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

remote_file 'home/user/maven.tar.gz' do
  source 'http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz'
  owner 'root'
  mode '0755'
  action :create
end

execute 'tar' do
  user 'root'
  cwd '/home/user/'
  action :run
  command 'tar zxvf maven.tar.gz'
  not_if { ::File.directory?('/home/user/apache*') }
end

execute 'move' do
  user 'root'
  cwd '/home/user'
  action :run
  command 'mv apache* maven'
  not_if { ::File.directory?('/home/user/maven/bin') }
end

execute 'set_path' do
  user 'root'
  cwd '/home/user/'
  action :run
  command 'PATH=$PATH:/home/user/maven/bin'
end

execute 'export_path' do
  user 'root'
  action :run
  command 'export PATH'
end

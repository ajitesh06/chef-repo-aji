# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'tomcat::default'

remote_file '/home/user/tomcat/webapps/ROOT.war' do
  source 'https://updates.jenkins-ci.org/download/war/2.52/jenkins.war'
  user 'root'
  mode '0755'
  action :create
end

execute 'shutdown' do
  user 'root'
  cwd '/home/user/tomcat/bin/'
  action :run
  command './shutdown.sh'
  not_if { ::File.directory?('/home/user/tomcat/webapps/ROOT/scripts/') }
end

execute 'remove' do
  user 'root'
  cwd '/home/user/tomcat/webapps/'
  action :run
  command 'rm ROOT/ -rf'
  not_if { ::File.directory?('/home/user/tomcat/webapps/ROOT/scripts/') }
end

execute 'startup' do
  user 'root'
  cwd '/home/user/tomcat/bin/'
  action :run
  command './startup.sh'
end

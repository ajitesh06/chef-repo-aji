# Cookbook:: linux
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
linux_user = node['linux']['user_id']
linux_group = node['linux']['group']
linux_root = node['linux']['root']
linux_conf_root = node['linux']['conf_root']
linux_sec_bin = node['linux']['sec_root']

group linux_group do
  group_name linux_group
  gid 20338
end
user linux_user do
  uid 3006554
  gid 20338
end
[linux_root, linux_conf_root]. each do |dirname|
  directory dirname do
    mode '755'
    recursive true
    owner linux_user
    group linux_group
    action :create
  end
end

service 'iptables' do
  action :stop
end

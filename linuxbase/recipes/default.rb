#
# Cookbook Name:: linuxbase
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['packages'].each do |pkg|
  package pkg
end

mdadm "/dev/md0" do
  devices [ "/dev/sdb", "/dev/sdc" ]
  action [:create, :assemble]
#store the mdadm config
end

#turn on xattr

directory "/data"

mount "/data" do
  device "/dev/md0"
  fstype "ext4"
  action [:mount, :enable]
end

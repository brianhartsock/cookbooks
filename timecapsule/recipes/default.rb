#
# Cookbook Name:: timecapsule
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'netatalk'
service 'netatalk'

cookbook_file '/etc/netatalk/afpd.conf' do
  source 'afpd.conf'
  mode 0644
  owner 'root'
  group 'root'

  notifies :restart, 'service[netatalk]'
end

template '/etc/netatalk/AppleVolumes.default' do
  source 'AppleVolumes.default.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables :shares => node[:netatalk][:shares]

  notifies :restart, 'service[netatalk]'
end

#Avahi

['avahi-daemon', 'libnss-mdns'].each do |pkg|
  package pkg
end

service 'avahi-daemon'

cookbook_file '/etc/avahi/services/afpd.service' do
  source 'afpd.service'
  mode 0644
  owner 'root'
  group 'root'

  notifies :restart, 'service[avahi-daemon]'
end

group node['netatalk']['share_group']

node['netatalk']['shares'].each do |share|
  directory share['directory'] do
    owner 'root'
    group node['netatalk']['share_group']
    mode 0775
  end
end

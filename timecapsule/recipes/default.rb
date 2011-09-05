#
# Cookbook Name:: timecapsule
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'netatalk' do
    action :install
end

service 'netatalk'

cookbook_file '/etc/netatalk/afpd.conf' do
	source 'afpd.conf'
	mode 0644
	owner 'root'
	group 'root'

	notifies :restart, 'service[netatalk]'
end

cookbook_file '/etc/netatalk/AppleVolumes.default' do
	source 'AppleVolumes.default'
	mode 0644
	owner 'root'
	group 'root'

	notifies :restart, 'service[netatalk]'
end

#Avahi

['avahi-daemon', 'libnss-mdns'].each do |pkg|
	package pkg do
		action :install
	end
end

service 'avahi-daemon'

#Package, service?
cookbook_file '/etc/avahi/services/afpd.service' do
	source 'afpd.service'
	mode 0644
	owner 'root'
	group 'root'

	notifies :restart, 'service[avahi-daemon]'
end

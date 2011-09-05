#
# Cookbook Name:: shairport
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{libssl-dev libcrypt-openssl-rsa-perl libao-dev libio-socket-inet6-perl libwww-perl avahi-utils pkg-config}.each do |pkg|
	package pkg do
		action :install
	end
end

git '/usr/local/shairport' do
	repository 'https://github.com/albertz/shairport.git'
	action 'sync'
end

execute 'make' do
	command 'make'
	cwd '/usr/local/shairport'
end

template '/etc/init/shairport.conf' do
	source 'shairport.conf.erb'
	mode 0644
	owner 'root'
	group 'root'

	variables :name => node[:shairport][:name]

	notifies :restart, 'service[shairport]'
end

link '/etc/init.d/shairport' do
	to '/lib/init/upstart-job'
end

service 'shairport' do
	action :start
end


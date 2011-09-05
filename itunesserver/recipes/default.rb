#
# Cookbook Name:: itunesserver
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

['libid3tag0', 'mt-daapd'].each do |pkg|
	package pkg do
		action :install
	end
end

directory '/home/media/music' do
	owner 'brianhartsock'
	group 'brianhartsock'
	recursive true

	notifies :restart, "service[netatalk]"
end

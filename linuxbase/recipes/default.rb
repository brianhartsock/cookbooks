#
# Cookbook Name:: linuxbase
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

['git', 'vim', 'subversion'].each do |pkg|
	package pkg do
	    action :install
	end
end

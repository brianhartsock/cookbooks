#
# Cookbook Name:: itunesserver
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

['libid3tag0', 'mt-daapd'].each do |pkg|
  package pkg
end

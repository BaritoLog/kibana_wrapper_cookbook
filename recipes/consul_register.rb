#
# Cookbook:: kibana
# Recipe:: consul_register
#
# Copyright:: 2018, BaritoLog.
#
#

config = {
  "id": "#{node['hostname']}-kibana",
  "name": "kibana",
  "tags": ["app:"],
  "address": node['ipaddress'],
  "port": node['nginx']['port'],
  "meta": {
    "http_schema": "http"
  }
}

consul_register_service "kibana" do
  config config
  config_dir  node[cookbook_name]['consul']['config_dir']
  consul_bin  node[cookbook_name]['consul']['bin']
end

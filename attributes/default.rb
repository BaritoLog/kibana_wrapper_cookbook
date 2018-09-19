default['kibana']['config']['elasticsearch.url'] = 'http://el.baritolog.com:9200'
override['kibana']['config']['base_dir'] = '/opt/kibana'
override['kibana']['config']['logging.dest'] = '/var/log/kibana.log'
default['kibana']['version'] = '5.6.9'
default['nginx']['default_site_enabled'] = false
default['nginx']['user'] = node['kibana']['service_user']
default['nginx']['kibana_path'] = '/etc/nginx/conf.d/kibana.conf'
default['nginx']['ip_address'] = '0.0.0.0'
default['nginx']['port'] = 80
default['kibana']['config']['port'] = '5601'

# Attributes for registering this service to consul
default['kibana']['consul']['config_dir'] = '/opt/consul/etc'
default['kibana']['consul']['bin'] = '/opt/bin/consul'

require_relative 'spec_helper'

describe 'kibana_wrapper_cookbook::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.normal['kibana']['config']['elasticsearch.url'] = 'http://el.baritolog.com:9200'
      node.normal['kibana']['config']['base_dir'] = '/opt/kibana'
      node.normal['kibana']['config']['logging.dest'] = '/var/log/kibana.log'
      node.normal['kibana']['version'] = '5.6.9'
      node.normal['nginx']['default_site_enabled'] = false
      node.normal['nginx']['user'] = ''
      node.normal['nginx']['kibana_path'] = '/etc/nginx/conf.d/kibana.conf'
      node.normal['nginx']['ip_address'] = '0.0.0.0'
      node.normal['nginx']['port'] = '80'
      node.normal['kibana']['config']['port'] = '5601'
    end.converge(described_recipe)
  end

  it 'should install kibana' do
    expect(chef_run).to install_kibana5_install('kibana').with(
      version: '5.6.9',
      install_method: 'release',
      base_dir: '/opt/kibana',
      svc_user: ''
    )
  end

  it 'updates apt with default action' do
    expect(chef_run).to periodic_apt_update('update_to_install_nginx')
  end

  it 'installs nginx package' do
    expect(chef_run).to install_package('nginx')
  end

  it 'should create nginx configuration for kibana' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/kibana.conf').with(
      source: 'nginx.conf.erb',
      variables: {
        listen_address: '0.0.0.0',
        listen_port: '80',
        server_name: 'kibana',
        kibana_port: '5601'
      }
    )
  end

  it 'should setup systemd for kibana' do
    expect(chef_run).to create_systemd_service('kibana').with(
      unit_description: 'Kibana',
      service_type: 'simple',
      service_user: nil,
      service_environment: 'NODE_ENV=production',
      service_exec_start: '/opt/kibana/5.6.9/current/bin/kibana',
      install_wanted_by: 'multi-user.target'
    )
  end

  %w[sites-enabled sites-available conf.d].each do |conf_dir|
    it "should delete default configuration at #{conf_dir}" do
      expect(chef_run).to delete_file("/etc/nginx/#{conf_dir}/default")
    end
  end
end

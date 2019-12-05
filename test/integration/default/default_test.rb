# # encoding: utf-8

# Inspec test for recipe pathfinder-node::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe group('kibana') do
    it { should exist }
  end

  describe user('kibana')  do
    it { should exist }
  end
end

describe systemd_service('kibana') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/logrotate.d/kibana') do
its('mode') { should cmp '0644' }
end

describe systemd_service('consul') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe package('libnginx-mod-http-lua') do
  it { should be_installed }
end

describe package ('lua-cjson') do
  it { should be_installed }
end

describe file('/etc/nginx/conf.d/kibana.conf') do
  its('content') { should include("http://localhost/api/v1/query?query=increase(barito_producer_tps_exceeded_total%7Bapp_group=%22test%22%7D[1m])%20%3E%200") }
end

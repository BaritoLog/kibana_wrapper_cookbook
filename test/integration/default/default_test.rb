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

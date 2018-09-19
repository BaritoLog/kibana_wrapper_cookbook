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

describe package('kibana') do
  it { should be_installed }
end

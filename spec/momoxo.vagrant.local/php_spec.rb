require 'spec_helper'

%w{php php-gd php-mbstring php-mysql}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/php.ini') do
  it { should be_file }
end

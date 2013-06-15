require 'spec_helper'

describe file('/var/www/html/momoxo') do
  it { should be_directory }
end

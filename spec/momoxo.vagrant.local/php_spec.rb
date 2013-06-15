require 'spec_helper'

%w{php php-gd php-mbstring php-mysql}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/php.ini') do
  it { should be_file }
  it { should contain "^date.timezone = Asia/Tokyo" }

  it { should contain "^mbstring.language             = Japanese" }
  it { should contain "^mbstring.encoding_translation = On"       }
  it { should contain "^mbstring.http_input           = UTF-8"    }
  it { should contain "^mbstring.http_output          = pass"     }
  it { should contain "^mbstring.internal_encoding    = UTF-8"    }
  it { should contain '^mbstring.substitute_character = "?"'      }
end

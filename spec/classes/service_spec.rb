require 'spec_helper'

describe 'sssd' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "sssd::service class with default parameters on #{os}" do
          let(:params) {{ }}

	        describe 'sssd::service class' do
            it { should contain_service('sssd').with_ensure('running') }
	        end

          case facts[:osfamily]
          when 'RedHat'
            if facts[:os]['release']['major'] =~ /(6|7)/
              it { should contain_service('oddjobd').with_ensure('running') }
              it { should contain_service('messagebus').with_before('Service[sssd]') }
            end
          end

        end
      end
    end
  end
end

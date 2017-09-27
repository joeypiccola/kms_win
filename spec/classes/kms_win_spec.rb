require 'spec_helper'

describe 'kms_win' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context "passes with minimal params" do
        let (:params) {{
          :key_management_service_name => 'kms.contoso.com',
        }}
        it { is_expected.to contain_registry_value('KeyManagementServiceName').with(
          'ensure' => 'present',
          'path'   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServiceName',
          'type'   => 'string',
          'data'   => 'kms.contoso.com',
          )
        }
        it { is_expected.to contain_registry_value('KeyManagementServicePort').with(
          'ensure' => 'present',
          'path'   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServicePort',
          'type'   => 'string',
          'data'   => '1688',
          )
        }
        it { is_expected.to contain_exec('slmgr_activation').that_subscribes_to(
          [
            'registry_value[KeyManagementServiceName]',
            'registry_value[KeyManagementServicePort]'
          ]
          )
        }
        it { is_expected.to compile }
        it { is_expected.to contain_exec('slmgr_activation').with(
          'path'        => 'C:/Windows/system32',
          'command'     => 'cscript.exe C:\Windows\System32\slmgr.vbs /ato',
          'refreshonly' => true
          )
        }
      end

      context "passes with additional params" do
        let (:params) {{
          :key_management_service_name => 'kms.contoso.com',
          :key_management_service_port => '443',
        }}        
        it { is_expected.to contain_registry_value('KeyManagementServicePort').with(
          'ensure' => 'present',
          'path'   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServicePort',
          'type'   => 'string',
          'data'   => '443',
          )
        }          
      end
    end
  end
end
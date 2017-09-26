# == Class: kms_win
#
# Manage the KMS client settings on a Windows machine.
#
# === Parameters
#
# [*key_management_service_name*]
#   The FQDN of the KMS server.
#
# [*key_management_service_port*]
#   The port of the KMS server. Defaults to '1688'.
#
# [*attempt_activation*]
#   Whether or not to run 'slmgr /ato' after setting either the KMS name or port.
#   Valid values are `true` and `false`. Defaults to `true`.
#
# === Examples
#
#  class { kms_win:
#    key_management_service_name = 'kmsserver.contoso.com',
#  }
#
# === Authors
#
# Joey Piccola <joey@joeypiccola.com>
#
# === Copyright
#
# Copyright (C) 2017 Joey Piccola.
#
class kms_win (

  $key_management_service_name = undef,
  $key_management_service_port = '1688',
  $attempt_activation = true,

){

  # parameter validation
  unless is_domain_name($key_management_service_name) {
    fail('Class[kms_win] key_management_service_name parameter must be a valid rfc1035 domain name')
  }  
  validate_re($key_management_service_port, '\d+', 'key_management_service_port parameter must be a number.')
  validate_bool($attempt_activation)

  registry_value { 'KeyManagementServiceName':
    ensure => present,
    path   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServiceName',
    type   => string,
    data   => $key_management_service_name,
  }
  
  registry_value { 'KeyManagementServicePort':
    ensure => present,
    path   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServicePort',
    type   => string,
    data   => $key_management_service_port,
  }
  
  if $attempt_activation {
    exec { 'slmgr_activation':
      path        => 'C:/Windows/system32',
      command     => 'cscript.exe C:\Windows\System32\slmgr.vbs /ato',
      subscribe   => [
        Registry_value['KeyManagementServiceName'],
        Registry_value['KeyManagementServicePort']
      ],
      refreshonly => true,
    }
  }

}
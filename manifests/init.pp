# == Class: kms_win
#
#   Manage the timezone on windows systems. Use WMI to verify what the timezone
#   currently is and tzutil.exe to set it.
#
# === Parameters
#
# [*timezone*]
#   The timezone to use. For a full list of available timezone run tzutil /l.
#   Use the listed time zone ID (e.g. 'Eastern Standard Time')
#
# === Examples
#
#  class { kms_win:
#    key_management_service_name = 'kmsserver.contoso.com',
#    key_management_service_port = '1688',
#  }
#
# === Authors
#
# Joey Piccola <joey@joeypiccola.com>
#
# === Copyright
#
# Copyright (C) 2016 Joey Piccola.
#
class kms_win (

  $key_management_service_name = undef,
  $key_management_service_port = undef,

){

  # parameter validation
  validate_string($key_management_service_name)
  validate_re($key_management_service_port, '\d+', 'key_management_service_port parameter must be a number.')

  registry_value { 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServiceName':
    ensure => present,
    type   => string,
    data   => $key_management_service_name,
    notify => exec['slmgr_activation'],
  }
  
  registry_value { 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\KeyManagementServicePort':
    ensure => present,
    type   => string,
    data   => $key_management_service_port,
    notify => exec['slmgr_activation'],
  }

  exec { 'slmgr_activation':
    command  => 'cmd.exe cscript C:\Windows\System32\slmgr.vbs /ato',
    refreshonly => true,
  }

}
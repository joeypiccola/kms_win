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
  #validate_string($KeyManagementServiceName)
  #validate_re($KeyManagementServicePort, '\d+', 'KeyManagementServicePort parameter must be a number.')

  exec { 'set-keymanagementservicename':
    command  => "New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name KeyManagementServiceName -Value '${key_management_service_name}' -PropertyType String -Force",
    onlyif   => "if (((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform').KeyManagementServiceName -eq '${key_management_service_name}') -and (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform' | Select-Object -ExpandProperty 'KeyManagementServiceName' -ErrorAction Stop)) {exit 1}",
    provider => powershell,
  }


  exec { 'set-keymanagementserviceport':
    command  => "New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name KeyManagementServicePort -Value '${key_management_service_port}' -PropertyType String -Force",
    onlyif   => "if (((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform').KeyManagementServicePort -eq '${key_management_service_port}') -and (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform' | Select-Object -ExpandProperty 'KeyManagementServicePort' -ErrorAction Stop)) {exit 1}",
    provider => powershell,
  }  

}
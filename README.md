# kms_win
|AppVeyor|Forge Version|Forge PDK Version|Forge Downloads|
|--------|-------------|-----------------|---------------|
[![AppVeyor][appveyor-badge]][appveyor] | [![Puppet Forge][forge-version-badge]][forge] | [![Puppet Forge][forge-pdk-badge]][forge] | [![Puppet Forge][forge-downloads-badge]][forge]

Manage the KMS client settings on a Windows machine.

## Parameters

 * ```key_management_service_name``` - The FQDN of the KMS server.
 * ```key_management_service_port``` - [Optional] The port of the KMS server. Defaults to '1688'.
 * ```attempt_activation```          - [Optional] Whether or not to run 'slmgr /ato' after setting either the KMS name or port. Defaults to 'true'.

## Usage
At a minimum set the ```key_management_service_name``` to the FQDN of your KMS server.

## Example
```ruby
class { 'kms_win':
  key_management_service_name => 'kmsserver.contoso.com',
}
```

## License
Kms_win is released under the [MIT license](http://www.opensource.org/licenses/MIT).

[appveyor]: https://ci.appveyor.com/project/joeypiccola/kms-win
[appveyor-badge]: https://ci.appveyor.com/api/projects/status/fq8fcmxoded3dl7j/branch/master?svg=true&passingText=master%20-%20PASSING&pendingText=master%20-%20PENDING&failingText=master%20-%20FAILING
[forge]: https://forge.puppet.com/jpi/kms_win
[forge-downloads-badge]: https://img.shields.io/puppetforge/dt/jpi/kms_win
[forge-pdk-badge]: https://img.shields.io/puppetforge/pdk-version/jpi/kms_win
[forge-version-badge]: https://img.shields.io/puppetforge/v/jpi/kms_win
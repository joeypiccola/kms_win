# kms_win

Manage the KMS client settings on a Windows machine.

## Parameters

 * ```key_management_service_name``` - The FQDN of the KMS server.
 * ```key_management_service_port``` - [Optional] The port of the KMS server. Defaults to '1688'.
 * ```attempt_activation```          - [Optional] Whether or not to run 'slmgr /ato' after setting either the KMS name or port. Defaults to 'true'.

## Usage
At a minimum set the ```key_management_service_name``` to the FQDN of your KMS server.

## Example
```ruby
class { kms_win:
  key_management_service_name = 'kmsserver.contoso.com',
}
```
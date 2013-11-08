denyhosts
=========

Samples
-------
```
include denyhosts
```
```
denyhosts::service { 'default': ensure => running, enable => true }
```
```
denyhosts::config { 'default': purge_deny => '8w' }
```
```
denyhosts::allow { 'default':
  whitelist => [ '192.168.1.*' ],
}
```
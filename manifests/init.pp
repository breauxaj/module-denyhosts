# Class: denyhosts
#
# This class installs denyhosts package
#
# Parameters:
#
#  ensure: (default latest)
#    Determine the state of the packages
#
# Actions:
#   - Installs the list of packages
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'denyhosts':
#      ensure => 'latest'
#    }
#
class denyhosts (
  $ensure = $::denyhosts::params::denyhosts_package_ensure
) inherits ::denyhosts::params {
  package { $::denyhosts::params::denyhosts_package:
    ensure   => $ensure,
  }

  $allow = hiera_hash('denyhosts::allow',{})
  create_resources('denyhosts::allow',$allow)

  $config = hiera_hash('denyhosts',{})
  create_resources('denyhosts::config',$config)

  service { $::denyhosts::params::denyhosts_service:
    ensure  => running,
    enable  => true,
    require => Package[$::denyhosts::params::denyhosts_package],
  }

}

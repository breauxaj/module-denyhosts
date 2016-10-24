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
# Requires:
#
#  EPEL repository
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'denyhosts':
#      ensure => 'latest'
#    }
#
#  To remove the installation, use:
#
#    class { 'denyhosts':
#      ensure => 'absent'
#    }
#
class denyhosts (
  $ensure = 'latest'
) inherits ::denyhosts::params {
  package { $::denyhosts::params::denyhosts_package:
    ensure  => $ensure,
  }

  service { $::denyhosts::params::denyhosts_service:
    ensure  => running,
    enable  => true,
    require => Package[$::denyhosts::params::denyhosts_package],
  }

}

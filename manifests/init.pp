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
class denyhosts (
  $ensure = $::denyhosts::params::denyhosts_package_ensure
) inherits ::denyhosts::params {
  package { $::denyhosts::params::denyhosts_package:
    ensure  => $ensure,
  }

  case $::operatingsystem {
    'Amazon': {
      $denyhosts_script  = '/usr/bin/denyhosts.py'

      if defined(Class["stdlib"]) {
        file_line { 'python2.6':
          path   => $denyhosts_script,
          line   => '#!/usr/bin/python2.6',
          match  => '^#!/usr/bin/python$',
          notify => Service[$::denyhosts::params::denyhosts_service],
        }
      } else {
        fail("The stdlib module is required for support on ${::operatingsystem} based system.")
      }
    }
    default: { }
  }

  $config = hiera_hash('denyhosts',{})
  create_resources('denyhosts::config',$config)

  service { $::denyhosts::params::denyhosts_service:
    ensure  => running,
    enable  => true,
    require => Package[$::denyhosts::params::denyhosts_package],
  }

}

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
){
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  package { $required:
    ensure  => $ensure,
  }

}

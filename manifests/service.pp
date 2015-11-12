# Define: denyhosts::service
#
# This define manages the Denyhosts service
#
# Parameters:
#
#  ensure:
#    Controls the state of the service
#
#  enable:
#    Controls the service start on boot
#
# Actions:
#   - Stops/starts the Denyhosts service
#
# Requires:
#
#  EPEL repository
#
# Sample Usage:
#
#  To enable the service, use:
#
#    denyhosts::service { 'default':
#      ensure => running,
#      enable => true
#    }
#
define denyhosts::service (
  $ensure = running,
  $enable = true
) {
  include ::denyhosts

  service { $::denyhosts::params::denyhosts_service:
    ensure  => running,
    enable  => true,
    require => Package[$::denyhosts::params::denyhosts_package],
  }

}

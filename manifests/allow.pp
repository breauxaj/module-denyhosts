# Define: denyhosts::allow
#
# This define configures the whitelist
#
# Parameters:
#
#  whitelist:
#    Array of IP addresses to whitelist
#
# Actions:
#   - Updates the allowed-hosts file with configured whitelist
#   - Notify the denyhosts service
#
# Sample Usage:
#
#  To whitelist an IP, use:
#
#    denyhosts::allow { 'default':
#      whitelist => [ '192.168.1.1' ]
#    }
#
define denyhosts::allow (
  $whitelist = [ '' ]
) {
  include ::denyhosts

  file { $::denyhosts::params::denyhosts_allowed:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('denyhosts/allowed.erb'),
    notify  => Service[$::denyhosts::params::denyhosts_service],
    require => File[$::denyhosts::params::denyhosts_path],
  }

  file { $::denyhosts::params::denyhosts_path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Package[$::denyhosts::params::denyhosts_package],
  }

}

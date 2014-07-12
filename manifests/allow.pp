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
# Requires:
#
#  EPEL repository
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
  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'allowed-hosts',
  }

  $depends = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  $path = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/lib/denyhosts',
  }

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  file { "${path}/${config}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('denyhosts/allowed-hosts.erb'),
    require => File[$path],
    notify  => Service[$service],
  }

  file { $path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Package[$depends],
  }

}

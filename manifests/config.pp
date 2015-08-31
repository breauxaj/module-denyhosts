# Define: denyhosts::config
#
# This define configures denyhosts
#
# Parameters:
#
#  value:
#    The corresponding value for the associated key (title/name)
#
# Actions:
#   - Applies settings to the denyhosts.conf file
#
# Requires:
#
#  EPEL repository
#
# Sample Usage:
#
#  To configure the service, use:
#
#    denyhosts::config { 'default':
#      admin_email => 'admin@domain.com',
#    }
#
define denyhosts::config (
  $value
) {
  include ::denyhosts

  $key = $title

  $context = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/etc/denyhosts.conf',
  }

  augeas { "denyhosts_conf/${key}":
    context => $context,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
  }

}

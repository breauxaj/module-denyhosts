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

  augeas { "denyhosts_conf/${key}":
    context => $::denyhosts::params::denyhosts_config,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
  }

}

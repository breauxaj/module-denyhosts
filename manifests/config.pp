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
#    denyhosts::config {
#      'ADMIN_EMAIL': value => 'admin@domain.com';
#    }
#
define denyhosts::config (
  $value
) {
  include ::denyhosts

  $key = $title

  augeas { "denyhosts_conf/${key}":
    context => $::denyhosts::params::denyhosts_context,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
    notify  => Service[$::denyhosts::params::denyhosts_service],
  }

}

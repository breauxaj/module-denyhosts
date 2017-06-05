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
    lens    => 'Simplevars.lns',
    incl    => $::denyhosts::params::denyhosts_config,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
    notify  => Service[$::denyhosts::params::denyhosts_service],
    require => Package[$::denyhosts::params::denyhosts_package],
  }

}

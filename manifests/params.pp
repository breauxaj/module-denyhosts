# Class: denyhosts::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#   - Does not support other osfamily patterns - redhat only
#
class denyhosts::params {
  $denyhosts_package_ensure = 'latest'

  case $::operatingsystem {
    'CentOS', 'Debian', 'OracleLinux', 'RedHat', 'Scientific': {
      $denyhosts_path    = '/var/lib/denyhosts'

      $denyhosts_allowed = "${denyhosts_path}/allowed-hosts"

      $denyhosts_context = '/files/etc/denyhosts.conf'

      $denyhosts_package = 'denyhosts'

      $denyhosts_service = 'denyhosts'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::operatingsystem} based system.")
    }
  }

}

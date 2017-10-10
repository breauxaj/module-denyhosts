# Class: denyhosts::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class denyhosts::params {
  $denyhosts_package_ensure = 'latest'

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        default: {
          case $::operatingsystemmajrelease {
            default: {
              $denyhosts_path    = '/var/lib/denyhosts'
              $denyhosts_allowed = "${denyhosts_path}/allowed-hosts"
              $denyhosts_config  = '/etc/denyhosts.conf'
              $denyhosts_package = 'denyhosts'
              $denyhosts_service = 'denyhosts'
            }
          }
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}

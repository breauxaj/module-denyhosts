# Class: denyhosts::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#   - Does not support other osfamily patterns - redhat only
#
class denyhosts::params {
  case $::osfamily {
    'redhat': {
      $denyhosts_path    = '/var/lib/denyhosts'

      $denyhosts_allowed = "${denyhosts_path}/allowed-hosts"

      $denyhosts_context = '/files/etc/denyhosts.conf'

      $denyhosts_package = 'denyhosts'

      $denyhosts_service = 'denyhosts'
    }
    default: { }
  }

}
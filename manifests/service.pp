define denyhosts::service (
  $ensure = running,
  $enable = true
) {
  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  service { $service:
    ensure => $ensure,
    enable => $enable,
  }

}

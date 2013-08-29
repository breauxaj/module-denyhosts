class denyhosts {
  Class['denyhosts']->Class['ssh']

  $required = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  package { $required: ensure => latest }

}

define denyhosts::service ( $ensure = running,
                            $enable = true ) {
  $service = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  service { $service:
    ensure => $ensure,
    enable => $enable,
  }

}

class denyhosts {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  package { $required:
    ensure  => latest,
    require => Package['openssh'],
  }

}

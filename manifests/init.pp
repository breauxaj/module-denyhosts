class denyhosts {
  Class['denyhosts']->Class['ssh']

  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  package { $required: ensure => latest }

}

class denyhosts (
  $ensure = 'latest'
){
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  package { $required:
    ensure  => $ensure,
    require => Package['openssh'],
  }

}

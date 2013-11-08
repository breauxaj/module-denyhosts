define denyhosts::allow (
  $whitelist = [ '' ]
) {
  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'allowed-hosts',
  }

  $path = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/lib/denyhosts',
  }

  file { "${path}/${config}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('denyhosts/allowed-hosts.erb'),
    require => File[$path],
  }

  file { $path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Package['denyhosts'],
  }

}

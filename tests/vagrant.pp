node default {
  include ::denyhosts

  denyhosts::allow { 'default':
    whitelist => [
      '192.168.0.1',
      '172.16.0.1'
    ]
  }

  denyhosts::config {
    'ADMIN_EMAIL': value => 'admin@domain.com';
  }

}

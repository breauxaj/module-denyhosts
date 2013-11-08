define denyhosts::config (
  $secure_log = '/var/log/secure',
  $hosts_deny = '/etc/hosts.deny',
  $purge_deny = '4w',
  $purge_threshold = '',
  $block_service = 'sshd',
  $deny_threshold_invalid = '5',
  $deny_threshold_valid = '10',
  $deny_threshold_root = '1',
  $deny_threshold_restricted = '',
  $work_dir = '/var/lib/denyhosts',
  $suspicious_login_report_allowed_hosts = 'YES',
  $hostname_lookup = 'NO',
  $lock_file = '/var/lock/subsys/denyhosts',
  $admin_email = 'root',
  $smtp_host = 'localhost',
  $smtp_port = '25',
  $smtp_username = '',
  $smtp_password = '',
  $smtp_from = 'DenyHosts <nobody@localhost>',
  $smtp_subject = 'DenyHosts Report from $[HOSTNAME]',
  $smtp_date_format = '',
  $syslog_report = '',
  $allowed_hosts_hostname_lookup = 'NO',
  $age_reset_value = '5d',
  $age_reset_root = '25d',
  $age_reset_restricted = '25d',
  $age_reset_invalid = '10d',
  $reset_on_success = '',
  $plugin_deny = '/usr/bin/true',
  $plugin_purge = '/usr/bin/true',
  $userdef_failed_entry_regex = [ '' ],
  $daemon_log = '/var/log/denyhosts',
  $daemon_log_time_format = '',
  $daemon_log_message_format = '',
  $daemon_sleep = '30s',
  $daemon_purge = '1h'
) {
  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/etc/denyhosts.conf',
  }

  file { $config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('denyhosts/denyhosts.erb'),
  }

}
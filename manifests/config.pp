# Define: denyhosts::config
#
# This define configures denyhosts
#
# Parameters:
#
#  purge_deny:
#    Frequency to purge entries from hosts.deny file
#
#  purge_threshold:
#    Number of times a host will be purged
#
#  block_service:
#    Which service will be blocked
#
#  deny_threshold_invalid:
#    Block each host after the number of failed logins with invalid user
#
#  deny_threshold_valid:
#    Block each host after the number of failed logins with valid user
#
#  deny_threshold_root:
#    Block each host after the number of failed logins for root user
#
#  deny_threshold_restricted:
#    Block each host after the number of failed logins for users in restricted-usernames
#
#  work_dir:
#    Denyhosts will use to store data
#
#  suspicious_login_report_allowed_hosts:
#    Determines whethere suspicious logins will be reported from allowed hosts
#
#  hostname_lookup:
#    Determines whether Denyhosts performs a host name lookup
#
#  admin_email:
#    Reports will be sent to this user
#
#  smtp_host:
#    Specify an SMTP host or relay
#
#  smtp_port:
#    Specify the SMTP port to use
#
#  smtp_username:
#    Username for authenticated SMTP
#
#  smtp_password:
#    Password for authenticated SMTP
#
#  smtp_from:
#    Set a from address for reports
#
#  smtp_subject:
#    Set a subject for reports
#
#  smtp_date_format:
#    Set the date format for the report
#
#  syslog_report:
#    Send the denyhosts events to syslog
#
#  allowed_hosts_hostname_lookup:
#    Determines whether Denyhosts performs a host name lookup
#
#  age_reset_value:
#    Determines when failed logins will reset back to 0
#
#  age_reset_root:
#    Determines when failed logins for root will reset back to 0
#
#  age_reset_restricted:
#    Determines when failed logins for restricted users will reset back to 0
#
#  age_reset_invalid:
#    Determines when failed logins for invalid users will reset back to 0
#
#  reset_on_success:
#    Determines whether to reset on successful login
#
#  plugin_deny:
#    Triggered when a deny event is handled
#
#  plugin_purge:
#    Triggered when a purge event is handled
#
#  userdef_failed_entry_regex:
#    Define a regex for user matching
#
#  daemon_log:
#    Sets the log file for activity
#
#  daemon_log_time_format
#    Sets the time format for the activity log
#
#  daemon_log_message_format
#    Sets the message format for the activity log
#
#  daemon_sleep:
#    Sets the polling interval for the secure_log
#
#  daemon_purge:
#    Set the frequency of the purge task
#
# Actions:
#   - Applies settings to the denyhosts.conf file
#
# Requires:
#
#  EPEL repository
#
# Sample Usage:
#
#  To configure the service, use:
#
#    denyhosts::config { 'default':
#      admin_email => 'admin@domain.com',
#    }
#
define denyhosts::config (
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

  $depends = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'denyhosts' ],
  }

  $secure_log = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/log/secure',
  }

  $hosts_deny = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/etc/hosts.deny',
  }

  $lock_file = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/lock/subsys/denyhosts',
  }

  file { $config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('denyhosts/denyhosts.erb'),
    require => Package[$depends],
  }

}
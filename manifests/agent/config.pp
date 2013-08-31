class zabbix::agent::config {

  $config            = $zabbix::agent::config
  $config_template   = $zabbix::agent::config_template

  $source_ip = $zabbix::agent::source_ip
  $enable_remote_commands = $zabbix::agent::enable_remote_commands
  $log_remote_commands = $zabbix::agent::log_remote_commands
  $zabbix_server = $zabbix::agent::zabbix_server
  $listen_port = $zabbix::agent::listen_port
  $listen_ip = $zabbix::agent::listen_ip

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
    notify  => Service['zabbix-agent'],
  }

}

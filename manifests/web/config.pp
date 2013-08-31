class zabbix::web::config {

  $config            = $zabbix::web::config
  $config_template   = $zabbix::web::config_template

  $server_name = $zabbix::web::server_name
  $host_allow = $zabbix::web::host_allow
  $php_value_max_execution_time = $zabbix::web::php_value_max_execution_time
  $php_value_memory_limit = $zabbix::web::php_value_memory_limit
  $php_value_post_max_size = $zabbix::web::php_value_post_max_size
  $php_value_upload_max_filesize = $zabbix::web::php_value_upload_max_filesize
  $php_value_max_input_time = $zabbix::web::php_value_max_input_time
  $php_value_date_timezone = $zabbix::web::php_value_date_timezone

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
    notify  => Service['zabbix-web'],
  }

}

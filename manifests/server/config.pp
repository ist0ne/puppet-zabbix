class zabbix::server::config {

  $config            = $::zabbix::server::config
  $config_template   = $zabbix::server::config_template

  $node_id = $zabbix::server::node_id
  $listen_port = $zabbix::server::listen_port
  $source_ip = $zabbix::server::source_ip
  $listen_ip = $zabbix::server::listen_ip

  $db_scripts       = $zabbix::server::db_scripts
  $db_type          = $zabbix::server::db_type
  $db_host          = $zabbix::server::db_host
  $db_port          = $zabbix::server::db_port
  $db_socket        = $zabbix::server::db_socket
  $db_name          = $zabbix::server::db_name
  $db_user          = $zabbix::server::db_user
  $db_password      = $zabbix::server::db_password
  $db_root_password = $zabbix::server::db_root_password
  $log_file         = $zabbix::server::log_file
  $alert_scripts_path = $zabbix::server::alert_scripts_path
  $external_scripts = $zabbix::server::external_scripts
  $fping_location = $zabbix::server::fping_location
  $fping6_location = $zabbix::server::fping6_location

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
    notify  => Service['zabbix-server'],
  }

  if $dbtype == 'mysql' and $::osfamily == 'RedHat' {

    class { 'mysql::server':
      config_hash => { 'root_password' => "$db_root_password" }
    }

    mysql::db { $db_name:
      user     => $db_user,
      password => $db_password,
      host     => $db_host,
      grant    => ['all'],
    }

    exec{ "schema-import":
      command     => "/usr/bin/mysql ${db_name} < ${dbscriptdir}/schema.sql",
      logoutput   => true,
      environment => "HOME=/root",
      refreshonly => true,
      subscribe   => Database[$db_name],
    }

    exec{ "data-import":
      command     => "/usr/bin/mysql ${db_name} < ${dbscriptdir}/data.sql",
      logoutput   => true,
      environment => "HOME=/root",
      refreshonly => true,
      subscribe   => Database[$db_name],
    }

    exec{ "images-import":
      command     => "/usr/bin/mysql ${db_name} < ${dbscriptdir}/images.sql",
      logoutput   => true,
      environment => "HOME=/root",
      refreshonly => true,
      subscribe   => Database[$db_name],
    }

    Exec["schema-import"] -> Exec["images-import"] -> Exec["data-import"]

  }
  else {
    warning("Create ${db_name} database, Import initial schema and data.")
  }

}

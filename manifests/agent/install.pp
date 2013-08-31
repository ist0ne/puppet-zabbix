class zabbix::agent::install {

  $package_name   = $zabbix::agent::package_name
  $package_ensure = $zabbix::agent::package_ensure

  package { 'zabbix_agent':
    ensure => $package_ensure,
    name   => $package_name,
  }

}

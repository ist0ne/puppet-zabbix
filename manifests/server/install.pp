class zabbix::server::install {

  $package_name   = $zabbix::server::package_name
  $package_ensure = $zabbix::server::package_ensure

  package { 'zabbix_server':
    ensure => $package_ensure,
    name   => $package_name,
  }

}

class zabbix::web::install {

  $package_name   = $zabbix::web::package_name
  $package_ensure = $zabbix::web::package_ensure

  package { 'zabbix_web':
    ensure  => $package_ensure,
    name    => $package_name,
  }

}

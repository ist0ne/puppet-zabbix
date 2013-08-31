class zabbix::web::service {

  $service_enable = $zabbix::web::service_enable
  $service_ensure = $zabbix::web::service_ensure
  $service_manage = $zabbix::web::service_manage
  $service_name   = $zabbix::web::service_name

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'zabbix-web':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}

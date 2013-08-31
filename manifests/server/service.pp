class zabbix::server::service {

  $service_enable = $zabbix::server::service_enable
  $service_ensure = $zabbix::server::service_ensure
  $service_manage = $zabbix::server::service_manage
  $service_name   = $zabbix::server::service_name

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'zabbix-server':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}

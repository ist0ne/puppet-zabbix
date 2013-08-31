class zabbix::agent::service {

  $service_enable = $zabbix::agent::service_enable
  $service_ensure = $zabbix::agent::service_ensure
  $service_manage = $zabbix::agent::service_manage
  $service_name   = $zabbix::agent::service_name

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'zabbix-agent':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}

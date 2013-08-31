# Class: zabbix::agent
#
# manages the installation of the zabbix agent.  manages the package, service,
# zabbix_agentd.conf
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#    class { 'zabbix::agent':
#        source_ip     => '10.10.10.11',
#        zabbix_server => '10.10.10.11',
#        listen_ip     => '10.10.10.11',
#    }
#
class zabbix::agent (
  $config                 = $zabbix::params::agent_config,
  $config_template        = $zabbix::params::agent_config_template,
  $package_ensure         = $zabbix::params::agent_package_ensure,
  $package_name           = $zabbix::params::agent_package_name,
  $service_enable         = $zabbix::params::agent_service_enable,
  $service_ensure         = $zabbix::params::agent_service_ensure,
  $service_manage         = $zabbix::params::agent_service_manage,
  $service_name           = $zabbix::params::agent_service_name,
  $source_ip              = $zabbix::params::agent_source_ip,
  $enable_remote_commands = $zabbix::params::agent_remote_commands,
  $log_remote_commands    = $zabbix::params::agent_log_remote_commands,
  $zabbix_server          = $zabbix::params::agent_zabbix_server,
  $listen_port            = $zabbix::params::agent_listen_port,
  $listen_ip              = $zabbix::params::agent_listen_ip
) inherits zabbix::params {

  validate_absolute_path($config)
  validate_string($config_template)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)

  include '::zabbix::agent::install'
  include '::zabbix::agent::config'
  include '::zabbix::agent::service'

  anchor { 'zabbix::agent::begin': }
  anchor { 'zabbix::agent::end': }

  Anchor['zabbix::agent::begin'] -> Class['::zabbix::agent::install']
    -> Class['::zabbix::agent::config'] ~> Class['::zabbix::agent::service']
    -> Anchor['zabbix::agent::end']

}

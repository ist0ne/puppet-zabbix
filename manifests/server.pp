# Class: zabbix::server
#
# manages the installation of the zabbix server.  manages the package, service,
# zabbix_server.conf
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#    class { 'zabbix::server':
#        source_ip => '10.10.10.11',
#        listen_ip => '10.10.10.11',
#        db_type => 'mysql',
#        db_password => 'zabbixpwd',
#    }
#
class zabbix::server (
  $config            = $zabbix::params::server_config,
  $config_template   = $zabbix::params::server_config_template,
  $package_ensure    = $zabbix::params::server_package_ensure,
  $package_name      = $zabbix::params::server_package_name,
  $service_enable    = $zabbix::params::server_service_enable,
  $service_ensure    = $zabbix::params::server_service_ensure,
  $service_manage    = $zabbix::params::server_service_manage,
  $service_name      = $zabbix::params::server_service_name,
  $node_id = $zabbix::params::node_id,
  $listen_port = $zabbix::params::listen_port,
  $source_ip = $zabbix::params::source_ip,
  $listen_ip = $zabbix::params::listen_ip,
  $db_scripts      = $zabbix::params::db_scripts,
  $db_type           = $zabbix::params::db_type,
  $db_host           = $zabbix::params::db_host,
  $db_socket         = $zabbix::params::db_socket,
  $db_name           = $zabbix::params::db_name,
  $db_user           = $zabbix::params::db_user,
  $db_password       = $zabbix::params::db_password,
  $db_root_password    = $zabbix::params::db_root_password,
  $log_file         = $zabbix::params::server_log_file,
  $alert_scripts_path = $zabbix::params::server_alert_scripts_path,
  $external_scripts = $zabbix::params::server_external_scripts,
  $fping_location = $zabbix::params::server_fping_location,
  $fping6_location = $zabbix::params::server_fping6_location
) inherits zabbix::params {

  validate_absolute_path($config)
  validate_string($config_template)
  validate_re($package_ensure, [present, installed, absent, purged, held, latest])
  validate_array($package_name)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_absolute_path($db_scripts)
  validate_re($db_type, ['mysql', 'pgsql'])
  validate_string($db_host)
  validate_string($db_name)
  validate_string($db_user)
  validate_string($db_password)
  validate_string($db_root_password)
  validate_string($alert_scripts_path)
  validate_string($external_scripts)
  validate_string($fping_location)
  validate_string($fping6_location)

  include '::zabbix::server::install'
  include '::zabbix::server::config'
  include '::zabbix::server::service'

  anchor { 'zabbix::server::begin': }
  anchor { 'zabbix::server::end': }

  Anchor['zabbix::server::begin'] -> Class['::zabbix::server::install']
    -> Class['::zabbix::server::config'] ~> Class['::zabbix::server::service']
    -> Anchor['zabbix::server::end']

}

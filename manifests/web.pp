# Class: zabbix::web
#
# manages the installation of the zabbix web.  manages the package, service,
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#    class { 'zabbix::web':
#         server_name => 'zabbix.sample.com',
#         php_value_date_timezone => 'Asia/Shanghai',
#    }
#
class zabbix::web (
  $config            = $zabbix::params::web_config,
  $config_template   = $zabbix::params::web_config_template,
  $package_ensure    = $zabbix::params::web_package_ensure,
  $package_name      = $zabbix::params::web_package_name,
  $service_enable    = $zabbix::params::web_service_enable,
  $service_ensure    = $zabbix::params::web_service_ensure,
  $service_manage    = $zabbix::params::web_service_manage,
  $service_name      = $zabbix::params::web_service_name,
  $server_name = $zabbix::params::server_name,
  $host_allow = $zabbix::params::host_allow,
  $php_value_max_execution_time = $zabbix::params::php_value_max_execution_time,
  $php_value_memory_limit = $zabbix::params::php_value_memory_limit,
  $php_value_post_max_size = $zabbix::params::php_value_post_max_size,
  $php_value_upload_max_filesize = $zabbix::params::php_value_upload_max_filesize,
  $php_value_max_input_time = $zabbix::params::php_value_max_input_time,
  $php_value_date_timezone = $zabbix::params::php_value_date_timezone,
) inherits zabbix::params {

  validate_absolute_path($config)
  validate_string($config_template)
  validate_re($package_ensure, [present, installed, absent, purged, held, latest])
  validate_array($package_name)

  include '::zabbix::web::install'
  include '::zabbix::web::config'
  include '::zabbix::web::service'

  anchor { 'zabbix::web::begin': }
  anchor { 'zabbix::web::end': }

  Anchor['zabbix::web::begin'] -> Class['::zabbix::web::install']
    -> Class['::zabbix::web::config'] ~> Class['::zabbix::web::service']
    -> Anchor['zabbix::web::end']

}

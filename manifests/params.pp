# Class: zabbix::params
#
#   The zabbix configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class zabbix::params {

  $node_id                = 0
  $listen_port            = 10051
  $source_ip              = ''
  $listen_ip              = '0.0.0.0'
  $db_type                = 'mysql'
  $db_host                = 'localhost'
  $db_name                = 'zabbix'
  $db_user                = 'zabbix'
  $db_root_password       = ''
  $server_config_template = 'zabbix/zabbix-server.conf.erb'
  $server_package_ensure  = 'present'
  $server_service_enable  = true
  $server_service_ensure  = 'running'
  $server_service_manage  = true
  
  $agent_source_ip              = ''
  $agent_enable_remote_commands = 0
  $agent_log_remote_commands    = 0
  $agent_zabbix_server          = '127.0.0.1'
  $agent_listen_port            = '10050'
  $agent_listen_ip              = '0.0.0.0'
  $agent_config_template        = 'zabbix/zabbix-agent.conf.erb'
  $agent_package_ensure         = 'present'
  $agent_service_enable         = true
  $agent_service_ensure         = 'running'
  $agent_service_manage         = true
  
  $web_config_template           = 'zabbix/zabbix-web.conf.erb'
  $web_package_ensure            = 'present'
  $web_service_enable            = true
  $web_service_ensure            = 'running'
  $web_service_manage            = true
  $server_name                   = 'zabbix.example.com'
  $host_allow                    = 'all'
  $php_value_max_execution_time  = 300
  $php_value_memory_limit        = 128M
  $php_value_post_max_size       = 16M
  $php_value_upload_max_filesize = 2M
  $php_value_max_input_time      = 300
  $php_value_date_timezone       = 'Europe/Riga'

  case $::osfamily {
    'RedHat': {
      $server_config             = '/etc/zabbix/zabbix_server.conf'
      $server_package_name       = ['zabbix-server', "zabbix-server-${db_type}"]
      $server_service_name       = 'zabbix-server'
      $server_log_file           = '/var/log/zabbix/zabbix_server.log'
      $bd_password               = 'zabbix'
      $db_socket                 = '/var/lib/mysql/mysql.sock'
      $server_alert_scripts_path = '/usr/lib/zabbix/alertscripts'
      $server_external_scripts   = '/usr/lib/zabbix/externalscripts'
      $server_fping_location     = '/usr/sbin/fping'
      $server_fping6_location    = '/usr/sbin/fping6'
      $agent_config              = '/etc/zabbix/zabbix_agentd.conf'
      $agent_package_name        = ['zabbix-agent']
      $agent_service_name        = 'zabbix-agent'
      $web_config                = '/etc/httpd/conf.d/zabbix.conf'
      $web_package_name          = ['zabbix-web',"zabbix-web-${db_type}"]
      $web_service_name          = 'httpd'
      $db_scripts                = "/usr/share/doc/zabbix-server-mysql-${zabbixversion}/create"
    }
    'Debian': {
      $server_config             = '/etc/zabbix/zabbix_server.conf'
      $server_package_name       = ["zabbix-server-${db_type}"]
      $server_service_name       = 'zabbix-server'
      $server_log_file           = '/var/log/zabbix/zabbix_server.log'
      $db_password               = 'xCkl3DRa7qRz'
      $db_socket                 = '/var/run/mysqld/mysqld.sock'
      $server_alert_scripts_path = '/usr/lib/zabbix/alertscripts'
      $server_external_scripts   = '/usr/lib/zabbix/externalscripts'
      $server_fping_location     = '/usr/bin/fping'
      $server_fping6_location    = '/usr/bin/fping6'
      $agent_config              = '/etc/zabbix/zabbix_agentd.conf'
      $agent_package_name        = ['zabbix-agent']
      $agent_service_name        = 'zabbix-agent'
      $web_config                = '/etc/apache2/conf.d/zabbix'
      $web_package_name          = ['zabbix-frontend-php']
      $web_service_name          = 'apache2'
      $db_scripts                = '/usr/share/doc/zabbix-server-mysql/examples'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}

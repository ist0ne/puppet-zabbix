# Class: zabbix
#
#   This class installs zabbix software.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# Use hiera: /etc/puppet/hieradata/node/zabbix.sample.com.yaml
# classes: 'zabbix'
# zabbix::server::source_ip: '10.10.10.11'
# zabbix::server::listen_ip: '10.10.10.11'
# zabbix::server::db_type: 'mysql'
# zabbix::server::db_password: 'zabbixpwd'
#
# zabbix::web::server_name: 'zabbix.sample.com'
# zabbix::web::php_value_date_timezone: 'Asia/Shanghai'
#
class zabbix {

  include '::zabbix::server'
  include '::zabbix::web'

  anchor { 'zabbix::begin': }
  anchor { 'zabbix::end': }

  Anchor['zabbix::begin'] -> Class['::zabbix::server']
    -> Class['::zabbix::web'] -> Anchor['zabbix::end']

}

# Zabbix module for Puppet

This module manages zabbix on Linux (RedHat/Debian) distros. 

Pluginsync needs to be enabled for this module to function properly.
Read more about pluginsync in our [docs](http://docs.puppetlabs.com/guides/plugins_in_modules.html#enabling-pluginsync)

## Description

This module uses the fact osfamily which is supported by Facter 1.6.1+. If you do not have facter 1.6.1 in your environment, the following manifests will provide the same functionality in site.pp (before declaring any node):

    if ! $::osfamily {
      case $::operatingsystem {
        'RedHat', 'Fedora', 'CentOS', 'Scientific', 'SLC', 'Ascendos', 'CloudLinux', 'PSBM', 'OracleLinux', 'OVS', 'OEL': {
          $osfamily = 'RedHat'
        }
        'ubuntu', 'debian': {
          $osfamily = 'Debian'
        }
        'SLES', 'SLED', 'OpenSuSE', 'SuSE': {
          $osfamily = 'Suse'
        }
        'Solaris', 'Nexenta': {
          $osfamily = 'Solaris'
        }
        default: {
          $osfamily = $::operatingsystem
        }
      }
    }

This module depends on the [puppetlabs-stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) and [puppetlabs-mysql](https://github.com/puppetlabs/puppetlabs-mysql).

## Usage

Installs the zabbix server package.

    class { 'zabbix::server':
        source_ip => '10.10.10.11',
        listen_ip => '10.10.10.11',
        db_type => 'mysql',
        db_password => 'zabbixpwd',
    }

Installs the zabbix frontend package.

    class { 'zabbix::web':
         server_name => 'zabbix.sample.com',
         php_value_date_timezone => 'Asia/Shanghai',
    }

Installs the zabbix agent package.

    class { 'zabbix::agent':
        source_ip => '10.10.10.11',
        zabbix_server => '10.10.10.11',
        listen_ip => '10.10.10.11',
    }

Use hiera: /etc/puppet/hieradata/node/zabbix.sample.com.yaml

    classes: 'zabbix'
    zabbix::server::source_ip: '10.10.10.11'
    zabbix::server::listen_ip: '10.10.10.11'
    zabbix::server::db_type: 'mysql'
    zabbix::server::db_password: 'zabbixpwd'
    
    zabbix::web::server_name: 'zabbix.sample.com'
    zabbix::web::php_value_date_timezone: 'Asia/Shanghai'


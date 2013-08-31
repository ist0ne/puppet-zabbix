Facter.add("zabbixversion") do
  setcode do
    Facter::Util::Resolution.exec('/usr/sbin/zabbix_server -V |/usr/sbin/zabbix_server -V |sed -n "s/.*v\([0-9]\.[0-9]\.[0-9]\).*/\1/p"')
  end
end

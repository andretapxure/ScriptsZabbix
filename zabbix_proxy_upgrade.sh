#!/bin/sh
case $(uname -a | uname -a | cut -f3 -d ' ' | cut -f4 -d '.') in
"el6")
  rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/6/x86_64/zabbix-release-4.2-1.el6.noarch.rpm
  ;;
"el7")
  rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
  ;;
*)
  echo "*******************************Versao nao compativel**************************************"
  ;;
esac  
yum -y clean all
yum -y update
service zabbix-proxy stop && service zabbix-agent stop
yum -y upgrade zabbix-proxy-sqlite3 zabbix-agent
service zabbix-proxy start && service zabbix-agent start
chkconfig zabbix-agent on && chkconfig zabbix-proxy on
zabbix_agentd -V | grep zabbix_agentd
zabbix_proxy -V | grep zabbix_proxy

#!/bin/bash
set -e

wget https://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz

yum install nrpe -y
mkdir -p /usr/lib64/nagios/plugins
cp nagios-plugins-2.1.1.tar.gz /usr/lib64/nagios/plugins/plugins.tar.gz
cd /usr/lib64/nagios/plugins/
tar xzvf plugins.tar.gz
cd nagios-plugins-2.1.1
./configure --prefix=/usr/lib64/nagios/plugins && make && make install
cd ..
cp libexec/* .
chown nagios:nagios *
rm /etc/nagios/nrpe.cfg
touch /etc/nagios/nrpe.cfg

echo "log_facility=daemon
pid_file=/var/run/nagios/nrpe.pid
server_port=5666
nrpe_user=nagios
nrpe_group=nagios
#allowed_hosts=10.179.253.73,54.152.62.134
allowed_hosts=54.152.62.134
dont_blame_nrpe=1
debug=1
command_timeout=60
connection_timeout=300
include_dir=/etc/nagios/nrpe.d/

#command[checknginx]=/usr/lib64/nagios/plugins/checknginx.sh 2>&1
command[check_ro_mounts]=/usr/lib64/nagios/plugins/check_ro_mounts \$ARG1$
command[checkmaestro]=/usr/lib64/nagios/plugins/check_nginx.sh -S -s /cameralab
command[checkcameralab]=/usr/lib64/nagios/plugins/check_nginx.sh -S -s /maestro/api
command[usedspace_bash]=/usr/lib64/nagios/plugins/usedspace.sh
command[check_users]=/usr/lib64/nagios/plugins/check_users \$ARG1$
command[check_cpu_stats]=/usr/lib64/nagios/plugins/check_cpu_stats.sh \$ARG1$
command[check_load]=/usr/lib64/nagios/plugins/check_load \$ARG1$
command[check_disk]=/usr/lib64/nagios/plugins/check_disk \$ARG1$
command[check_swap]=/usr/lib64/nagios/plugins/check_swap \$ARG1$
command[check_procs]=/usr/lib64/nagios/plugins/check_procs \$ARG1$
command[check_memory]=/usr/lib64/nagios/plugins/check_memory \$ARG1$
command[check_file_age]=/usr/lib64/nagios/plugins/check_file_age \$ARG1$
command[check_dir_age]=/usr/lib64/nagios/plugins/check_dir_age \$ARG1$
command[check_mailq]=/usr/lib64/nagios/plugins/check_mailq \$ARG1$
command[check_hpjd]=/usr/lib64/nagios/plugins/check_hpjd \$ARG1$
command[check_ntp]=/usr/lib64/nagios/plugins/check_ntp \$ARG1$
command[check_ntp_peer]=/usr/lib64/nagios/plugins/check_ntp_peer \$ARG1$
command[check_ntp_time]=/usr/lib64/nagios/plugins/check_ntp_time \$ARG1$
command[check_snmp]=/usr/lib64/nagios/plugins/check_snmp \$ARG1$
command[check_time]=/usr/lib64/nagios/plugins/check_time \$ARG1$
command[check_tcp]=/usr/lib64/nagios/plugins/check_tcp \$ARG1$
command[check_cluster]=/usr/lib64/nagios/plugins/check_cluster \$ARG1$
command[check_ide_smart]=/usr/lib64/nagios/plugins/check_ide_smart \$ARG1$
command[check_postgres]=/usr/lib64/nagios/plugins/check_postgres \$ARG1$
command[check_raid]=/usr/lib64/nagios/plugins/check_raid \$ARG1$
command[check_time_skew]=/usr/lib64/nagios/plugins/check_time_skew \$ARG1$

ciphers=ADH-AES256-SHA:ADH-AES128-SHA" >> /etc/nagios/nrpe.cfg
chmod 644 /etc/nagios/nrpe.cfg
num=$(echo "$(sudo iptables -n -L -v --line-numbers)" | egrep "^[0-9]" | wc -l)
if [ $num = 0 ]; then
    echo "IPTables NOT RUNNING, continuing"
else
    echo "IPTables enabled, adding rule for nrpe"
    iptables -I INPUT -p tcp --dport 5666 -J ACCEPT
    iptables-save
fi
service nrpe restart
rm -f nagios-plugins-2.1.1.tar.*
echo "OpsView Configuration Complete"


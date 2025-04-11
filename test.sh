# Stop the services
csadm services --stop

# Reset selinux permissions
semanage fcontext -d '/opt/cyops-api(/.*)?'
semanage fcontext -d '/opt/cyops-api/public(/.*)?'
semanage fcontext -d '/opt/cyops-api/src/Entity(/.*)?'
semanage fcontext -d '/opt/cyops-api/var(/.*)?'
semanage fcontext -d '/opt/cyops-api/var/backups(/.*)?'
semanage fcontext -d '/opt/cyops-api/var/cache/prod/pools/system'
semanage fcontext -d '/opt/cyops-api/var/cache/prod/pools/system(/.*)?'
semanage fcontext -d '/opt/cyops-api/var/metadata(/.*)?'
semanage fcontext -d '/opt/cyops-api/var/security(/.*)?'
semanage fcontext -d '/opt/cyops-api/web(/.*)?'
semanage fcontext -d '/opt/cyops-api/workspace'
semanage fcontext -d '/opt/cyops-archival/(/.*)?'
semanage fcontext -d '/opt/cyops-archival/archival/archival/archival_wsgi.ini'
semanage fcontext -d '/opt/cyops-auth(/.*)?'
semanage fcontext -d '/opt/cyops-auth/.env/bin/python3'
semanage fcontext -d '/opt/cyops-auth/server/csdassrv.py'
semanage fcontext -d '/opt/cyops-integrations/(/.*)?'
semanage fcontext -d '/opt/cyops-integrations/integrations/integrations/integrations_wsgi.ini'
semanage fcontext -d '/opt/cyops-routing-agent/(/.*)?'
semanage fcontext -d '/opt/cyops-routing-agent/postman/configs/agents(/.*)?'
semanage fcontext -d '/opt/cyops-routing-agent/postman/postman_wsgi.ini'
semanage fcontext -d '/opt/cyops-search(/.*)?'
semanage fcontext -d '/opt/cyops-tomcat(/*)?'
semanage fcontext -d '/opt/cyops-ui(/.*)?'
semanage fcontext -d '/opt/cyops-ui/locales(/.*)?'
semanage fcontext -d '/opt/cyops-ui/widgets(/.*)?'
semanage fcontext -d '/opt/cyops-workflow(/.*)?'
semanage fcontext -d '/opt/cyops-workflow/sealab/sealab_wsgi.ini'
semanage fcontext -d '/opt/cyops/configs/cyops-ui/locales/mmd(/.*)*'
semanage fcontext -d '/usr/lib/systemd/system/cyops-auth.*'
semanage fcontext -d '/var/log/cyops(/.*)?'
semanage fcontext -d '/var/log/cyops/cyops-api'
semanage fcontext -d '/var/log/cyops/cyops-api(/.*)?'
semanage fcontext -d '/var/log/cyops/cyops-api/last_config_export.log'
semanage fcontext -d '/var/log/cyops/cyops-api/last_config_import.log'
semanage fcontext -d '/var/log/cyops/cyops-api/last_contenthubsync.log'
semanage fcontext -d '/var/log/cyops/cyops-api/last_system_publish.log'
semanage fcontext -d '/var/log/cyops/cyops-archival'
semanage fcontext -d '/var/log/cyops/cyops-archival(/.*)?'
semanage fcontext -d '/var/log/cyops/cyops-auth'
semanage fcontext -d '/var/log/cyops/cyops-gateway'
semanage fcontext -d '/var/log/cyops/cyops-integrations'
semanage fcontext -d '/var/log/cyops/cyops-integrations(/.*)?'
semanage fcontext -d '/var/log/cyops/cyops-notifier'
semanage fcontext -d '/var/log/cyops/cyops-routing-agent'
semanage fcontext -d '/var/log/cyops/cyops-routing-agent(/.*)?'
semanage fcontext -d '/var/log/cyops/cyops-search'
semanage fcontext -d '/var/log/cyops/cyops-workflow'
semanage fcontext -d '/var/log/cyops/cyops-workflow(/.*)?'
semanage fcontext -d '/var/log/cyops/fsr-elevate(/.*)?'
semanage fcontext -d '/var/log/cyops/fsr-elevate/fsr-elevate.log'

# added by danny to remove some strange selinux permissions
semanage fcontext -d '/opt/cyops-api/src/StaticFile(/.*)?'
sudo chattr -i /opt/cyops-integrations/.env/pip.conf
rm -rf '/opt/fsr-elevate'
sudo chattr -i /etc/cyops-release
rm -f '/etc/cyops-release'


# cleanup some installed modules
rm -f '/home/csadmin/.eula_agreed'
rm -f '/home/csadmin/.vm_configured'
rm -f '/home/csadmin/.config-vm.response'
rm -f '/home/csadmin/.vm_configuration_failed'
rm -f '/home/csadmin/ha.conf'

# set permission
restorecon -RFv /opt
restorecon -RFv /var

# force remove packages
yum remove postgresql16 -y
rm -rf '/var/lib/pgsql'
yum remove elasticsearch -y
rm -rf '/etc/elasticsearch'
rm -rf '/var/lib/elasticsearch'
yum remove rabbitmq-server -y
rm -rf '/etc/rabbitmq'
rm -rf '/var/lib/rabbitmq'

# remove FortiSOAR packages
packages=$(yum list installed "cyops*" 2>/dev/null | awk 'NR>1 {print $1}')
for package in $packages; do
    echo "Removing $package..."
    yum remove -y "$package"
done
rm -rf /opt/cyops*

# removing the fsr-integrations
userdel fsr-integrations
groupdel fsr-integrations
rm -rf '/home/fsr-integrations'

#!/bin/bash
#
# This script runs just after system installation, when the host reboots.
# It applies puppet configuration, then restores normal puppet behavior and
# triggers a last reboot.
#
#=============================================================================

exec >/dev/console 2>&1

clear
echo "========================================================================"
echo "  Applying puppet initial configuration"
echo
echo "Please wait..."
echo

/opt/puppetlabs/bin/puppet agent -t --ignoreschedules --no-show_diff 2>&1 \
	| tee -a /var/log/puppet-bootstrap.log

echo "========================================================================"
echo

if [ $? != 0 ] ; then
        echo "Error(s) detected - Please type <Enter> to reboot"
        read a </dev/console
fi

echo "Rebooting..."
sleep 2

systemctl disable puppet-bootstrap
systemctl enable puppet

systemctl reboot


#!/bin/bash
#
# This script runs once just after system installation, when the host reboots.
#
#=============================================================================

exec >/dev/console 2>&1

clear >/dev/console
echo "========================================================================"
echo "  Applying puppet initial configuration"
echo
echo "Please wait..."
echo

mlib pup_bootstrap

status=$?

echo "========================================================================"
echo

echo "Disabling puppet bootstrap"
systemctl disable puppet-bootstrap
mv /usr/lib/systemd/system/puppet-bootstrap.service /var/tmp # Security

if [ $status != 0 ] ; then
		echo "========================================================================"
        echo "Error(s) detected - Type <Enter> to login..."
		echo "========================================================================"
		echo
else
	echo "Rebooting..."
	sleep 2
	reboot
fi

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

systemctl disable puppet-bootstrap

if [ $status != 0 ] ; then
        echo "Error(s) detected - Type <Enter> to reboot or ^C to login"
        read a </dev/console
fi

echo "Rebooting..."
sleep 2
systemctl reboot

## The issue

When installing a system using foreman and puppet, the foreman template usually installs puppet-agent. Then, after the last reboot, the puppet service starts and will configure the newly-installed host according to the site configuration.

Unfortunately :

- The puppet service does not apply the catalog immediately after being started,
- nothing is displayed on the host console, puppet output is hidden and returned back to foreman via the puppet server.

## The solution

puppet-bootstrap is a small utility to solve these issues:

- It takes control at the end of the kickstart reboot,
- runs the puppet agent, applying the host configuration,
- displays puppet output on the system console,
- disables itself for the subsequent boots, restores the normal puppet agent behavior, and reboots the system.

This provides a much cleaner way to install a host. Once the host has been configured by puppet-bootstrap and rebooted, the installation is finished and the host is ready.

## Usage

- In your finish script, before or after puppet-agent installation, install puppet-bootstrap (use 'make rpm' to build package) and enable the service ('systemctl enable puppet-bootstrap)',
- that's all : after the next reboot, puppet-bootstrap will take control, run puppet, disable itself, and trigger a last reboot.

## Notes

This release is limited to systems based on systemd. Adapting it to SYS V systems is trivial and I'll probably do it when I have time. Contributions welcome.
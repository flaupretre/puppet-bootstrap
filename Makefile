#
# Makefile
#
#============================================================================

SOFTWARE_NAME = puppet-bootstrap

include config.mk

TGZ_PREFIX = $(SOFTWARE_NAME)-$(SOFTWARE_VERSION)
TGZ_FILE = $(TGZ_PREFIX).tar.gz
RPM_PATTERN=$(TGZ_PREFIX)-*.noarch.rpm

#=====================================

all: tgz

.PHONY: clean tgz install all rpm

install:
	chmod +x build/install.sh
	build/install.sh

specfile: specfile.in
	chmod +x build/mkspec.sh
	build/mkspec.sh "$(SOFTWARE_VERSION)"

tgz: $(TGZ_FILE)

$(TGZ_FILE): clean
	/bin/rm -rf /tmp/$(TGZ_PREFIX)
	mkdir /tmp/$(TGZ_PREFIX)
	tar cf - . | ( cd /tmp/$(TGZ_PREFIX) ; tar xpf - )
	( cd /tmp ; rm -rf $(TGZ_PREFIX)/.git ; tar cf - ./$(TGZ_PREFIX) ) | gzip >$(TGZ_FILE)
	/bin/rm -rf /tmp/$(TGZ_PREFIX)

rpm: tgz specfile
	/bin/rm -rf $(HOME)/rpmbuild/RPMS/noarch/$(RPM_PATTERN)
	rpmbuild -bb --define="_sourcedir `pwd`" --define="dist `sysfunc os_dist_macro`" specfile
	mv -f $(HOME)/rpmbuild/RPMS/noarch/$(RPM_PATTERN) .
	/bin/rm -rf $(HOME)/rpmbuild/BUILD/$(TGZ_PREFIX)
	
clean:
	/bin/rm -rf bin specfile $(TGZ_FILE) $(RPM_PATTERN)

#============================================================================

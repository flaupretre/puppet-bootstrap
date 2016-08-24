#
# Install script. Create target tree and move pre-built files there.
#
#============================================================================

# $INSTALL_ROOT variable can be set by the calling environment and is optional.
# If not set, everything will be installed relative to '/'.

#----------

cd `dirname $0`/..
BASE_DIR=`/bin/pwd`

INSTALL_DIR="$INSTALL_ROOT"
if [ -z "$INSTALL_ROOT" ] ; then
	INSTALL_DIR='/'
else
	INSTALL_DIR="$INSTALL_ROOT"
	/bin/rm -rf $INSTALL_DIR
	mkdir -p $INSTALL_DIR
fi

export BASE_DIR INSTALL_DIR

#-- Copy files

cp -rp src/* $INSTALL_DIR

chmod +x $INSTALL_DIR/opt/puppet-bootstrap/bin/*

###############################################################################

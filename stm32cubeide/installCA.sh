#/usr/bin/env /bin/bash
################################################################################
# Copyright (c) 2020 STMicroelectronics.
# All rights reserved. This program and the accompanying materials
# is the property of STMicroelectronics and must not be
# reproduced, disclosed to any third party, or used in any
# unauthorized manner without written consent.
################################################################################

set -e

thisdir=$(readlink -m $(dirname $0))

# If not supplied, consider this is run from installation dir.
installdir=${1:-$thisdir}

# Java cacerts possible locations
java_cacerts_candidates="/etc/pki/java/cacerts
	/etc/ssl/certs/java/cacerts
"

for cacerts_loc in $java_cacerts_candidates
do
	if [ -e $cacerts_loc ]; then
		ln -sf $cacerts_loc $installdir/jre/lib/security/cacerts
		echo "Java cacerts symlinked to $cacerts_loc"
		exit 0
	fi
done

# No found Java cacert.
# Try to generate one from known cacerts locations
while read line
do
	set junk $line
	cert_candidate=$2
	if [ -e "$cert_candidate" ]; then
		$installdir/jre/bin/keytool -import -trustcacerts -file $cert_candidate -keystore $installdir/jre/lib/security/cacerts -storepass changeit -noprompt
		echo "Generated Java cacerts from $cert_candidate"
		exit 0
	fi
done << EOL
	/etc/ssl/certs/ca-certificates.crt                "Debian/Ubuntu/Gentoo etc."
	/etc/pki/tls/certs/ca-bundle.crt                  "Fedora/RHEL 6"
	/etc/ssl/ca-bundle.pem                            "OpenSUSE"
	/etc/pki/tls/cacert.pem                           "OpenELEC"
	/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem "CentOS/RHEL 7"
	/etc/ssl/cert.pem                                 "Alpine Linux"
EOL

# Last chance: if there already is a java installation, try to use its cacerts
if ( type -p java ) ; then
	java_cacerts_candidates=$(readlink -m $(dirname $(readlink -m $(which java)))/../lib/security/cacerts)
	ln -sf $java_cacerts_candidates $installdir/jre/lib/security/cacerts
	echo "Java cacerts symlinked to JRE: $java_cacerts_candidates"
	exit 0
fi

# If we reach here, no java cacert could be setup.
echo >&2 "Warning: cannot update STM32CubeIDE Java SSL certificates with system ones. Issues might occur with SSL certificate validation."
exit 1

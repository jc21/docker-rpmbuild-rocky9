#!/bin/bash -e

# dnf tweaks
#echo "fastestmirror=1" >> /etc/dnf/dnf.conf
sed -i 's/best=True/best=False/g' /etc/dnf/dnf.conf
sed -i 's/skip_if_unavailable=False/skip_if_unavailable=True/g' /etc/dnf/dnf.conf

dnf -y update
dnf -y install epel-release dnf-plugins-core
dnf localinstall -y 'https://yum.jc21.com/jc21.rpm'
dnf clean all && dnf makecache
dnf config-manager --enable crb
dnf -y update
dnf -y --allowerasing install \
	aspell-devel \
	autoconf \
	automake \
	bzip2-devel \
	chrpath \
	cmake \
	curl \
	cyrus-sasl-devel \
	enchant-devel \
	expect \
	fastlz-devel \
	fontconfig-devel \
	freetype-devel \
	gcc-c++ \
	gettext-devel \
	git \
	gmp-devel \
	httpd-devel \
	kernel-devel \
	krb5-devel \
	libX11-devel \
	libXpm-devel \
	libacl-devel \
	libcurl-devel \
	libdb-devel \
	libedit-devel \
	liberation-sans-fonts \
	libevent-devel \
	libgit2 \
	libicu-devel \
	libjpeg-turbo-devel \
	libmcrypt-devel \
	libmemcached-devel \
	libpng-devel \
	libtiff-devel \
	libtool \
	libtool-ltdl-devel \
	libuuid-devel \
	libwebp-devel \
	libxml2-devel \
	libxslt-devel \
	make \
	memcached \
	mock \
	net-snmp-devel \
	openldap-devel \
	openssl-devel \
	pam-devel \
	pcre-devel \
	perl-generators \
	postgresql-devel \
	recode-devel \
	rpm-build \
	rpmdevtools \
	rpmlint \
	scl-utils \
	scl-utils \
	scl-utils-build \
	scl-utils-build \
	sqlite-devel \
	sudo \
	systemd-devel \
	systemtap-sdt-devel \
	tokyocabinet-devel \
	unixODBC-devel \
	wget \
	which \
	yum-utils \
	zlib-devel

dnf clean all
rm -rf /var/cache/yum

# Remove requiretty from sudoers main file
sed -i '/Defaults    requiretty/c\#Defaults    requiretty' /etc/sudoers
sed -i '/Defaults.*XAUTHORITY"/a Defaults    env_keep += "LANG HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy"' /etc/sudoers

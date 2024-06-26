FROM rockylinux:9

LABEL maintainer="Jamie Curnow <jc@jc21.com>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# build files
COPY bin/build-spec /bin/
COPY bin/build-all /bin/

# Sudo
COPY etc/sudoers.d/wheel /etc/sudoers.d/
RUN chown root:root /etc/sudoers.d/*

COPY scripts/install-base.sh /tmp/install-base.sh
RUN /tmp/install-base.sh \
	&& rm -f /tmp/install-base.sh

# Rpm User
RUN adduser -G wheel rpmbuilder \
	&& mkdir -p /home/rpmbuilder/rpmbuild/{BUILD,SPECS,SOURCES,BUILDROOT,RPMS,SRPMS,tmp} \
	&& chmod -R 777 /home/rpmbuilder/rpmbuild

COPY .rpmmacros /home/rpmbuilder/
USER rpmbuilder

WORKDIR /home/rpmbuilder

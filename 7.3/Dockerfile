FROM davyinsa/cloudrup-webserver:7.3
ENV TERM="xterm" \
    REGISTRY_REBUILD_VERSION=7.x-2.5 \
    # PROVISION_REPO=https://github.com/ipumpkin/provision-1.git \
    # PROVISION_BRANCH=cloudrup \
    PROVISION_REPO=https://github.com/aegir-project/provision \
    PROVISION_BRANCH=7.x-3.x \
    # You may change this environment at run time. User UID 1 is created with this email address.
    AEGIR_CLIENT_EMAIL=aegir@aegir.local.computer \
    AEGIR_CLIENT_NAME=admin \
    AEGIR_PROFILE=hostmaster \
    AEGIR_VERSION=7.x-3.x \
    AEGIR_WORKING_COPY=0 \
    # Must be fixed across versions so we can upgrade containers.
    AEGIR_HOSTMASTER_ROOT=/var/aegir/hostmaster \
    # The Hostname of the database server to use
    AEGIR_DATABASE_SERVER=database \
    # For dev images (7.x-3.x branch)
    AEGIR_MAKEFILE=http://cgit.drupalcode.org/provision/plain/aegir.make
# For Releases:
# ENV AEGIR_MAKEFILE http://cgit.drupalcode.org/provision/plain/aegir-release.make?h=$AEGIR_VERSION

RUN drush dl --destination=/usr/share/drush/commands registry_rebuild-$REGISTRY_REBUILD_VERSION -y && \
    git clone $PROVISION_REPO --branch $PROVISION_BRANCH /usr/share/drush/commands/provision

ENV GOSU_VERSION 1.12
RUN set -eux; \
# save list of currently installed packages for later so we can clean up
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates wget cron; \
	if ! command -v gpg; then \
		apt-get install -y --no-install-recommends gnupg2 dirmngr; \
	elif gpg --version | grep -q '^gpg (GnuPG) 1\.'; then \
# "This package provides support for HKPS keyservers." (GnuPG 1.x only)
		apt-get install -y --no-install-recommends gnupg-curl; \
	fi; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
# clean up fetch dependencies
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu --version; \
	gosu nobody true

COPY rootfs /
#USER aegir
WORKDIR /var/aegir
VOLUME /var/aegir
EXPOSE 22 80 443

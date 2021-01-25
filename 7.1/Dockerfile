FROM davyinsa/cloudrup-webserver:7.1
ENV TERM="xterm" \
    REGISTRY_REBUILD_VERSION=7.x-2.5 \
    PROVISION_REPO=https://github.com/ipumpkin/provision-1.git \
    PROVISION_BRANCH=cloudrup \
    # PROVISION_REPO=https://github.com/aegir-project/provision \
    # PROVISION_BRANCH=7.x-3.x \
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

RUN apt update -y && \
    apt install -y sendmail && \
    drush dl --destination=/usr/share/drush/commands registry_rebuild-$REGISTRY_REBUILD_VERSION -y && \
    git clone $PROVISION_REPO --branch $PROVISION_BRANCH /usr/share/drush/commands/provision

COPY rootfs /
#USER aegir
WORKDIR /var/aegir
VOLUME /var/aegir
EXPOSE 22 80 443

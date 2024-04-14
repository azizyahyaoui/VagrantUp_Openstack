#!/bin/bash

set -e
set -x

if [ -f .env ] ; then
  source .env
  export HOST_IP
fi

touch local.conf

cat <<EOF > local.conf
# Sample ``local.conf`` for user-configurable variables in ``stack.sh``

# NOTE: Copy this file to the root DevStack directory for it to work properly.       

# ``local.conf`` is a user-maintained settings file that is sourced from ``stackrc``.
# This gives it the ability to override any variables set in ``stackrc``.
# Also, most of the settings in ``stack.sh`` are written to only be set if no        
# value has already been set; this lets ``local.conf`` effectively override the      
# default values.

# This is a collection of some of the settings we have found to be useful
# in our DevStack development environments. Additional settings are described        
# in https://docs.openstack.org/devstack/latest/configuration.html#local-conf        
# These should be considered as samples and are unsupported DevStack code.

# The ``localrc`` section replaces the old ``localrc`` configuration file.
# Note that if ``localrc`` is present it will be used in favor of this section.      
[[local|localrc]]

# Minimal Contents
# ----------------

# While ``stack.sh`` is happy to run without ``localrc``, devlife is better when     
# there are a few minimal variables set:

# If the ``*_PASSWORD`` variables are not set here you will be prompted to enter     
# values for them by ``stack.sh``and they will be added to ``local.conf``.
ADMIN_PASSWORD=$ADMIN_PASSWORD
DATABASE_PASSWORD=$DATABASE_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD

# ``HOST_IP`` and ``HOST_IPV6`` should be set manually for best results if
# the NIC configuration of the host is unusual, i.e. ``eth1`` has the default        
# route but ``eth0`` is the public interface.  They are auto-detected in
# ``stack.sh`` but often is indeterminate on later runs due to the IP moving
# from an Ethernet interface to a bridge on the host. Setting it here also
# makes it available for ``openrc`` to include when setting ``OS_AUTH_URL``.
# Neither is set by default.
IP_VERSION=4 
HOST_IP=$HOST_IP
## Neutron options
FIXED_RANGE=$FIXED_RANGE
IPV4_ADDRS_SAFE_TO_USE=$IPV4_ADDRS_SAFE_TO_USE
FLOATING_RANGE=$FLOATING_RANGE
PUBLIC_NETWORK_GATEWAY=$PUBLIC_NETWORK_GATEWAY
Q_FLOATING_ALLOCATION_POOL=$Q_FLOATING_ALLOCATION_POOL
PUBLIC_INTERFACE=$PUBLIC_INTERFACE

# Open vSwitch provider networking configuration
#Q_ASSIGN_GATEWAY_TO_PUBLIC_BRIDGE=FALSE
#Q_USE_PROVIDER_NETWORKING=True
#Q_USE_PROVIDERNET_FOR_PUBLIC=True
#OVS_PHYSICAL_BRIDGE=br-ex
#PUBLIC_BRIDGE=br-ex
#OVS_BRIDGE_MAPPINGS=public:br-ex

LIBVIRT_TYPE=kvm

# Logging
# -------

# By default ``stack.sh`` output only goes to the terminal where it runs.  It can
# be configured to additionally log to a file by setting ``LOGFILE`` to the full
# path of the destination log file.  A timestamp will be appended to the given name.
LOGFILE=$DEST/logs/stack.sh.log

# Old log files are automatically removed after 2 days to keep things neat.  Change
# the number of days by setting ``LOGDAYS``.
LOGDAYS=2

# Nova logs will be colorized if ``SYSLOG`` is not set; turn this off by setting
# ``LOG_COLOR`` false.
#LOG_COLOR=False


# Using milestone-proposed branches
# ---------------------------------

# Uncomment these to grab the milestone-proposed branches from the
# repos:
#CINDER_BRANCH=milestone-proposed
#GLANCE_BRANCH=milestone-proposed
#HORIZON_BRANCH=milestone-proposed
#KEYSTONE_BRANCH=milestone-proposed
#KEYSTONECLIENT_BRANCH=milestone-proposed
#NOVA_BRANCH=milestone-proposed
#NOVACLIENT_BRANCH=milestone-proposed
#NEUTRON_BRANCH=milestone-proposed
#SWIFT_BRANCH=milestone-proposed

# Using git versions of clients
# -----------------------------
# By default clients are installed from pip.  See LIBS_FROM_GIT in
# stackrc for details on getting clients from specific branches or
# revisions.  e.g.
# LIBS_FROM_GIT="python-ironicclient"
# IRONICCLIENT_BRANCH=refs/changes/44/2.../1

# Swift
# -----

# Swift is now used as the back-end for the S3-like object store. Setting the
# hash value is required and you will be prompted for it if Swift is enabled
# so just set it to something already:
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5

# For development purposes the default of 3 replicas is usually not required.
# Set this to 1 to save some resources:
SWIFT_REPLICAS=1

# The data for Swift is stored by default in (``$DEST/data/swift``),
# or (``$DATA_DIR/swift``) if ``DATA_DIR`` has been set, and can be
# moved by setting ``SWIFT_DATA_DIR``. The directory will be created
# if it does not exist.
SWIFT_DATA_DIR=$DEST/data

# Cinder volume size
#VOLUME_BACKING_FILE_SIZE=$CINDER_VOLUME_BACKING_FILE_SIZE

#disable_service mysql
#enable_service postgresql
#DATABASE_TYPE=postgresql

# Add magnum K8s cluster and with own dashboard #stable/2024.1
#enable_plugin magnum https://opendev.org/openstack/magnum
#enable_plugin magnum-ui https://opendev.org/openstack/magnum-ui 

# Add Octavia load balancer 
#enable_service octavia


RECLONE=yes


EOF
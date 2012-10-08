#!/bin/bash -feux

umask 022

# dont prompt
export DEBIAN_FRONTEND="noninteractive"

# update packages
aptitude update
aptitude install -q -y linux-server linux-headers-server linux-image-server linux-headers
aptitude install -q -y ntp
aptitude hold linux-server linux-headers-server linux-image-server linux-headers
aptitude clean

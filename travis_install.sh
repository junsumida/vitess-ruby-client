#!/bin/bash
#
# Builds and installs gRPC on a box (from sources).
#
# In order to build using Travis (http://travis-ci.org) we must be able to
# build our development environment. This script does that. It is intended
# to run from file .travis.yml as root on Ubuntu 12.04 LTS.

mkdir pre_build
cd pre_build
git clone https://github.com/grpc/grpc.git
cd grpc
# Currently we can build against this gRPC label.
git checkout 4831d02cc2341ec2233ff9d9ef66fb9a86138fb7
git submodule update --init
apt-get install -y build-essential autoconf libtool
make
make install prefix=/opt

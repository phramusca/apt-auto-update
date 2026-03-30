#!/bin/bash
# Exécuté par cron (root) ou via : apt-auto-update run
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold upgrade
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean

#!/bin/bash

  set -e
  set -x

  
  if [ ! -f /home/vagrant/.vagrant-reload ]; then
    # "------------------------------"
    # "Checking for updates ..."
    #  "------------------------------"
    sudo apt update && sudo apt upgrade -yq
    sudo /etc/needrestart/restart.d/systemd-manager >/dev/null
    sleep 1s
    
    #  "------------------"
    #  " Install git ..."
    #  "------------------"
    sudo apt-get install -yq git && git config --global http.postBuffer 524288000

    #  "----------------------"
    #  "Set the host name..."
    #  "----------------------"
    sudo hostnamectl set-hostname vagrant-openstack --static
    sudo cp .vagrant_data/etc/hosts /etc/hosts
    sleep 1s

    #  "---------------------------------------"
    #  "Set the host netplan network and DNS ..."
    #  "---------------------------------------"
    sudo sudo cp .vagrant_data/etc/netplan/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
    sudo chmod 600 /etc/netplan/50-vagrant.yaml
    sudo netplan try
    sudo netplan apply
    sudo systemctl restart systemd-networkd
    sleep 1s
    
    #  "----------------------------------------------"
    #  "Check netplan network and DNS connectivity ..."
    #  "----------------------------------------------"
    ping -c 4 docs.openstack.org

    sudo rm /var/lib/dpkg/lock >/dev/null
    sudo rm /var/lib/apt/lists/lock >/dev/null
    sudo rm /var/cache/apt/archives/lock >/dev/null
    sudo rm -rf /var/lib/apt/lists/* >/dev/null
    touch /home/vagrant/.vagrant-reload

    #  "------------------------------"
    #  "System update successfully ..."
    #  "Reloading..."
    #  "------------------------------"
    #sudo init 6
  else
    #  "-----------------------------------------------------"
    #  "System already  updated and reloaded successfully!.. "
    #  "-----------------------------------------------------"
    echo "Next"
  fi

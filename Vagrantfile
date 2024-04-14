# -*- mode: ruby -*-
# vi: set ft=ruby :


VM_NAME = "Vagrant_devstack"
VM_CPUS = 4
VM_RAM = 8096
DISK_SIZE = '70GB'
SHARED_FOLDER_HOST = "./data/"
SHARED_FOLDER_GUEST = "/home/vagrant/.vagrant_data/"
INTERNET_INTERFACE = "Qualcomm Atheros QCA9377 Wireless Network Adapter" #Hyper-V Virtual Ethernet Adapter
VAGRANT_BOX = "YahyaouiMedAziz/ubuntu-jammy-2204"

Vagrant.configure("2") do |config|

  config.vm.define 'openstack' do |openstack|
    openstack.vm.box = VAGRANT_BOX
    openstack.vm.provider "virtualbox" do |vb|
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.memory = VM_RAM
      vb.name = VM_NAME
      vb.cpus = VM_CPUS
    end
    
    openstack.disksize.size = DISK_SIZE
    openstack.vm.synced_folder SHARED_FOLDER_HOST, SHARED_FOLDER_GUEST

    # Configure host-only network (recommended for Devstack)
    openstack.vm.network "private_network", ip: "192.168.56.10", gateway: "192.168.1.1", dns: ["8.8.4.4", "8.8.8.8"]
    openstack.vm.network "forwarded_port", ip: "10.0.2.15", guest: 80, host: 8080, host_ip: "127.0.0.1", mac: "023b7bb73b2d"
    openstack.vm.network "public_network", ip: "192.168.1.32", bridge: INTERNET_INTERFACE
    openstack.vm.boot_timeout = 600
  end
  # Provision the virtual machine: updating and upgrading the VM
  config.vm.provision "shell", path: "./scripts/config.sh", run: "once"

  # Provision the virtual machine: Install devstack
  config.vm.provision "shell", path: "./scripts/MainScript.sh"

end
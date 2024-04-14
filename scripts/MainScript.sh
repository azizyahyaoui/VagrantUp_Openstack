#!/bin/bash

set -e
set -x


#create the stack user
  if id "stack" &>/dev/null; then
    echo "------------------------------"
    echo "User stack already exists!.."
    echo "------------------------------"
  else
    echo "------------------------------"
    echo "create the stack user..."
    echo "------------------------------"
    sudo useradd -s /bin/bash -d /opt/stack -m stack
    sudo chmod +x /opt/stack
    sudo chown -R stack:stack /opt/stack
    sudo echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
    sudo -u stack -i
    echo "------------------------------"
    echo "done!..."
    echo "------------------------------"
  fi
  sleep 1s

#disable firewalld
  echo "------------------------------"
  echo "disable firewalld..."
  echo "------------------------------"
  sudo systemctl stop ufw

cd /opt/stack
sudo -u stack -i /bin/bash << EOF

echo "------------------------------"
echo "clone the devstack  repo ..."
echo "-----------------------------"
if [ -d "devstack" ]; then
  echo "------------------------------------------------------------"
  echo "The folders devstack and requirements both already exists!.."
  echo "------------------------------------------------------------"
else
  git clone https://opendev.org/openstack/devstack.git -b stable/2024.1  devstack/
  sleep 1s
fi

echo "-------------------"
echo "Add local.conf ..."
echo "-------------------"
cd devstack/
sudo cp /home/vagrant/.vagrant_data/.env .env
sudo cp /home/vagrant/.vagrant_data/scripts/create_localconf.sh .
sudo chmod +x create_localconf.sh
./create_localconf.sh
sudo rm -f create_localconf.sh
sudo rm -f .env
sleep 1s

  echo "--------------------------------Start checking---------------------------------------"
    echo "-------------------------------"
    echo "Current user is:" && whoami
    echo "Home directory is:" && pwd
    echo "-------------------------------"
    echo "checking before the installation.."
    echo "---------- Permissions ---------------------"
    ls -la
    echo "-------------- local.conf ------------------"
    cat local.conf
    echo "------------- Networking -------------------"
    ifconfig
    echo "--------------------------------------------"
    ping -c 4 docs.openstack.org
    echo "------------- HOST_IP -------------------"
    echo $HOST_IP
  echo "------------------------------- End of checking -------------------------------------"
  sleep 5s

  echo "------------------------------------"
  echo "devstack installation ready to go..."
  echo "------------------------------------"
  ./clean.sh && sleep 1s
  ./run_tests.sh
  ./stack.sh

  source openrc admin admin


  echo "--------------------------"
  echo "Installed successfully ..."
  echo "--------------------------"

  # Open web UI in your browser (after provisioning)
  echo "Open http://$HOST_IP:8080/dashboard/  in your browser to access Horizon."

EOF






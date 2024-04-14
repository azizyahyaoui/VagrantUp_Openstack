# Setting Up an OpenStack Cloud Environment as a Sandbox
> Yahyaoui Med Aziz  | <azizyahyaoui@gmail.com> | 14042024.

## Introduction
This project aims to establish an OpenStack cloud environment utilizing Vagrant and DevStack in an all-in-one sandbox configuration. It serves as an ideal platform for personal exploration or educational endeavors, allowing users to delve into the intricacies of OpenStack.

## Requirements
- **DevStack**: A script utilized for the installation of OpenStack. For more information, please visit the [official DevStack website](https://opendev.org/openstack/devstack.git).
- **Vagrant**: Visit the [official Vagrant website](https://www.vagrantup.com/) for installation instructions.
- **Vagrant Plugins**:
  - `vagrant-cachier`: Facilitates the caching of packages to enhance provisioning speed.
  - `vagrant-disksize`: Enables configuration of disk size.
- **Vagrant Box**: A custom box tailored for this project, accessible at [YahyaouiMedAziz/ubuntu-jammy-2204](https://app.vagrantup.com/YahyaouiMedAziz/boxes/ubuntu-jammy-2204).
- **Virtualbox**: Utilized as the primary provider for Vagrant.

## Setup
1. Install Vagrant along with the required plugins.
2. Clone this repository and navigate to the project directory.

## Repository Contents

This repository contains essential data for provisioning OpenStack using Vagrant.

### Data Directory

The `data` directory encompasses sample environment files essential for configuration, updating, and installing openstack.

#### env.sample

The `env.sample` file serves as a template. Duplicate this file  or just create a '.env' file and input your environment variables accordingly.
```bash
touch .env
  or
mv env.sample .env
```
5. Populate the necessary environment variables.
```bash
ADMIN_PASSWORD=
DATABASE_PASSWORD=
#Networking
HOST_IP=
FIXED_RANGE="10.0.0.0/24"
IPV4_ADDRS_SAFE_TO_USE="/24"
FLOATING_RANGE="/24"
PUBLIC_NETWORK_GATEWAY=
Q_FLOATING_ALLOCATION_POOL=start=x.x.x.200,end=x.x.x.250
PUBLIC_INTERFACE=eth0
```
#### "Local.conf" configuration adjustments

To customize your OpenStack installation, you can add plugins, and configure Neutron networking, Nova, Cinder, and other components by editing the `local.conf` file. This can be done through the script located at: `data/scripts/create_localconf.sh`


6. Execute `vagrant up` to initiate the setup procedure.
7. Upon completion, access the OpenStack dashboard to begin exploration.
> Open http://<HOST_IP>/dashboard/  in your browser to access Horizon.

## License
This project is licensed under the MIT License. Refer to the [LICENSE](LICENSE) file for further details.


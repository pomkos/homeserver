Server build running FreeNAS 11.3 U1 and storage 2x RAIDZ2 of four WD RED 3tb hard drives each. Lives in my closet.

# Table of Contents

1. [Screenshot](#screenshot)
2. [VMs](#vms)
3. [Plugins](#plugins)
4. [Jails](#jails)
5. [Parts List](#parts-list)
6. [Helpful Scripts](#helpful-scripts)

# Screenshot

<img src="https://github.com/pomkos/homeserver/raw/master/Screen%20Shot%202021-01-14%20at%2011.55.10%20AM.png" width="720">

# VMs

Name | OS | Purpose
:---|:---|:---
ubuntu_host | Ubuntu 18.04 | Main VM that hosts [dash](dash.thegates.online), [peti.work](peti.work), [payme](payme.peti.work), [brotein](brotein.peti.work), [covid dash](covid.peti.work), and OpenVPN
ubuntu_jupyter | Ubuntu 18.04 | For the sole purpose of hosting JupyterLab
ubuntu_docker | Ubuntu 18.04 | Hosts docker and docker apps, specifically Bitwarden, Ghost, NginxProxyManager,Wordpress, Postgres DB, Portainer

# Plugins

Plugin | Purpose
:---|:---
qBittorrent | Downloading Linux ISOs

# Jails

Jail | Purpose
:---|:---
Nextcloud | Syncs folders and files between PC, laptop, phone. Easy access off site. Plugin wouldn't update so went all jail using [this script](https://github.com/danb35/freenas-iocage-nextcloud)
Plex | Streaming videos and shows to all devices. Jail is easier to update than plugin.


# Parts List

[PCPartPicker Part List](https://pcpartpicker.com/list/4yThfH)

Type|Item|Price
:----|:----|:----
**CPU** | [Intel Core i3-4330 3.5 GHz Dual-Core Processor](https://pcpartpicker.com/product/qMLypg/intel-cpu-bx80646i34330) | Purchased For $120.00 
**CPU Cooler** | [Cooler Master Hyper 212 EVO 82.9 CFM Sleeve Bearing CPU Cooler](https://pcpartpicker.com/product/hmtCmG/cooler-master-cpu-cooler-rr212e20pkr2) | Purchased For $36.99 
**Thermal Compound** | [StarTech Metal Oxide 1.5 g Thermal Paste](https://pcpartpicker.com/product/nL8Zxr/startech-thermal-paste-silvgrease1) | Purchased For $3.99 
**Motherboard** | [Supermicro X10SL7-F Micro ATX LGA1150 Motherboard](https://pcpartpicker.com/product/NhgPxr/supermicro-motherboard-x10sl7f) | Purchased For $237.00 
**Memory** | [Crucial 16 GB (2 x 8 GB) DDR3-1866 Memory](https://pcpartpicker.com/product/88Lypg/crucial-memory-ct2k8g3w186dm) | Purchased For $120.43 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $0.00 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $0.00 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $80.95 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $87.98 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $88.75 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $88.75 
**Storage** | [Western Digital Red 3 TB 3.5" 5400RPM Internal Hard Drive](https://pcpartpicker.com/product/7sTmP6/western-digital-internal-hard-drive-wd30efrx) | Purchased For $88.75 
**Power Supply** | [Solid Gear 750 W Semi-modular ATX Power Supply](https://pcpartpicker.com/product/8Hx9TW/solid-gear-power-supply-sdgr750e) | Purchased For $49.99 
**Custom** | [Rosewill Server Chassis/Server Case/Rackmount Case, 4U Metal Rack Mount Server Chassis with 15 bays](https://pcpartpicker.com/product/GHWrxr/rosewill-server-chassisserver-caserackmount-case-4u-metal-rack-mount-server-chassis-with-15-bays) | Purchased For $112.08 
**Custom**| Microcenter 3.0 USB Drive, 32gb| Purchased For $8.99 
**Custom**| FreeNAS| Purchased For $0.00 
**Custom**| Compressed Air| Purchased For $1.99 
 | *Prices include shipping, taxes, rebates, and discounts* |
 | **Total** | **$1126.64**
 | Generated by [PCPartPicker](https://pcpartpicker.com) 2020-04-22 09:12 EDT-0400 |

# Helpful Scripts

`add_kernel.sh` will add a python kernel linking from given conda environment to jupyterlab using the given display name. Created with heavy inspiration from [neatshell's simple bash template](https://gist.github.com/neatshell/5283811).

Prereqs:

* Conda if on Ubuntu, miniconda3 if on MacOS. 
* Must have python and ipykernel installed in given environment.
* Assumes .conda and /opt/miniconda folders are in home folder (change lines 100-107 as needed).

```bash
# give execute permission
sudo chmod 700 add_kernel.sh

# default os is mac
./add_kernel.sh -e my_env -d "My Env" -os "ubuntu" 
```

`--help` output:

```bash
usage: add_kernel MANDATORY [OPTION]

Adds a python kernel to the jupyterlab instance.

MANDATORY:
  -e, --env           str  Name of conda environment
  -d, --display_name  str  What is shown inside JupyterLab
OPTION:
  -o, --os            str  What os is used. Accepts 'mac' (default) or 'ubuntu' as parameters.
  -h, --help               Prints this help

example: add_kernel -e my_env -d 'My Env'
```

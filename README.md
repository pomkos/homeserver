Server build running FreeNAS 12.04 U4 and storage 2x RAIDZ2 of four WD RED 3tb hard drives each. Lives in my closet.

# Table of Contents

1. [Screenshot](#screenshot)
2. [VMs](#vms)
3. [Plugins](#plugins)
4. [Jails](#jails)
5. [Parts List](#parts-list)
    1. [HDD Table](#hard-drive-history)
7. [Helpful Scripts](#helpful-scripts)
    1. [Add Jupyter Kernel](#add_kernel)
    2. [Backup SMB](#backup_server)
    3. [Initialize Ubuntu](#initiate_ubuntu)
    4. [Mount USB Drive](#mount_usb)

# Screenshot

<img src="https://github.com/pomkos/homeserver/raw/master/freenas_screen.png" width="720">

# VMs

Name | OS | Purpose
:---|:---|:---
ubuntu_host | Ubuntu 18.04 | Main VM that hosts [dash](https://dash.thegates.online), [peti.work](https://peti.work), [payme](https://payme.peti.work), [brotein](https://brotein.peti.work), [covid dash](https://covid.peti.work), and OpenVPN
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
 
## Hard Drive History

Hard drives come and go, but data is for a lifetime. Currently installed HDD. 

| Mount| Serial           | Model                | Installed   | SATA  | Errors      |
| ---- | ---------------- | -------------------- | ----------- | ----- | ----------- |
| ada0 | WD-WCC[CENSORED] | WDC WD3[CENSORED]    | N/A         | SATA0 | 0           |
| ada2 | WD-WCC[CENSORED] | WDC WD3[CENSORED]    | Dec 24 2021 | SATA2 | 0           |
| ada3 | WD-WCC[CENSORED] | WDC WD3[CENSORED]    | Jan 4 2020  | SATA3 | self-healed |
| ada4 | WD-WCC[CENSORED] | WDC WD3[CENSORED]    | Jan 4 2022  | SATA4 | 0           |
| ada5 | WD-WX3[CENSORED] | WDC WD3[CENSORED]    | Apr 16 2021 | SATA5 | 0           |
| ada1 | WD-WX3[CENSORED] | WDC WD3[CENSORED]    | Jun 21 2021 | SATA1 | 0           |
| da0  | WD-WCC[CENSORED] | ATA WDC[CENSORED]    | Jun 7 2019  | BLUE2 | 0           |
| da1  | WD-WMC[CENSORED] | ATA WDC[CENSORED]    | N/A         | BLUE1 | 0           |
| da   | 070A6C53DE908E55 |                      | USB         |       |             |


# Helpful Scripts

## add_kernel

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

## backup_server

`backup_server.sh` initiates `rsync` command to backup SMB folders in order of importance. All outputs will be shown in the terminal and saved in `output.txt`. Created to backup FreeNAS shares to an external hard drive over the network. Modify:

* Line 3: change name or order of folders
* Line 8: change location of SMB mount and backup location

Sample output:

<img src="https://github.com/pomkos/homeserver/raw/master/backup_sample.png" width="720">

## initiate_ubuntu

`initiate_ubuntu.sh` will be a collection of commands to carry out common tasks whenever a new ubuntu server is created. Right now it:

1. Appends HDA SMB folder locations to fstab file
2. Creates new folders for the defined SMB folders under `/mnt/Network/$folder`
3. Creates `.smbcredentials` file with the passed `-u` and `-p` variables, with `chmod 600`
4. Mounts all folders in the fstab file

Modify:

* Lines 16-25, settings for server location, folder names, etc.
* Lines 132-146, folders that have spaces in them are special cases that need to be added to fstab with `\040` in place of space
* Line 158, if the password protected folder is not outside the $remote_mount folder

## mount_usb

`mount_usb.sh` asks user for drive info and then mounts the USB drive to

1. Prints all connected drives that are named "sd**"
2. Asks user for drive name (ex: sda1)
3. Asks user for file system type (ex: ntfs)
4. Mounts the drive to `/mnt/usb`
5. Shows contents of `/mnt/usb` so user can confirm it was mounted

Modify: 

1. Lines 47, 50, 52, 56 location to mount the drive to

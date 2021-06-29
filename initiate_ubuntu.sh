#!/bin/bash

###################################################
# Function: automate common ubuntu setup tasks    #
# Tasks:                                          #
#   - Create fstab file                           #
#   - Create /mnt/Network/$folder folders         #
#   - Mount HDA smb folders to /mnt/Network/*     #
# Script using neatshell's template               #
# https://gist.github.com/neatshell/5283811       #
###################################################

script="initiate_ubuntu"
#Declare the number of mandatory args
margs=2

# Common functions - BEGIN
function example {
    echo -e "example: $script -u VAL -p VAL"
}

function usage {
    echo -e "usage: $script MANDATORY [OPTION]\n"
}

function help {
  usage
    echo -e "MANDATORY:"
    echo -e "  -u, --username  VAL  The username of 'Peti' share on HDA"
    echo -e "  -p, --password  VAL  The password of 'Peti' share on HDA"
  example
}

# Ensures that the number of passed args are at least equals
# to the declared number of mandatory args.
# It also handles the special case of the -h or --help arg.
function margs_precheck {
	if [ $2 ] && [ $1 -lt $margs ]; then
		if [ $2 == "--help" ] || [ $2 == "-h" ]; then
			help
			exit
		else
	    	usage
			example
	    	exit 1 # error
		fi
	fi
}

# Ensures that all the mandatory args are not empty
function margs_check {
	if [ $# -lt $margs ]; then
	    usage
	  	example
	    exit 1 # error
	fi
}
# Common functions - END

# Custom functions - BEGIN
# Put here your custom functions
# Custom functions - END

# Main
margs_precheck $# $1

user=
pass=
ubu=

# Args while-loop
while [ "$1" != "" ];
do
   case $1 in
   -u  | --username )  shift
                          user=$1
                		  ;;
   -p  | --password )  shift
   						  pass=$1
			              ;;
   -h   | --help )        help
                          exit
                          ;;
   *)                     
                          echo "$script: illegal option $1"
                          usage
						  example
						  exit 1 # error
                          ;;
    esac
    shift
done

# Pass here your mandatory args for check
margs_check $user $pass

#############
# Main Body #
#############

### install requirements ###
sudo apt-get install cifs-utils -y

### append to fstab file and create folders###
#### initiate ####
sudo echo "" >> /etc/fstab
sudo echo "# Mounted from HDA Main"  >> /etc/fstab
sudo echo "" >> /etc/fstab
sudo mkdir /mnt/Network
#### folders ####
for folder in "Backups" "Documents" "Downloads" "Dump" "Home Videos" "Imports" "Matt Stuff" "Movies" "Music" "Pictures" "Steven" "TV"
do
#### folders with spaces ####
if [ "$folder" = "Home Videos" ]
then
    # Add to fstab
    sudo echo "//192.168.1.250/Server/Home\040Videos /mnt/Network/Home\040Videos cifs guest,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    sudo echo "" >> /etc/fstab
    # make directory
    sudo mkdir /mnt/Network/"$folder"
    echo "$folder folder created and added to fstab"
    echo ""
elif [ "$folder" = "Matt Stuff" ]
then
    sudo echo "//192.168.1.250/Server/Matt\040Stuff /mnt/Network/Matt\040Stuff cifs guest,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    sudo echo "" >> /etc/fstab
    sudo mkdir /mnt/Network/"$folder"
    echo "$folder folder created and added to fstab"
else
    sudo echo "//192.168.1.250/Server/$folder /mnt/Network/$folder cifs guest,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    sudo echo "" >> /etc/fstab
    sudo mkdir /mnt/Network/"$folder"
    echo "$folder folder created and added to fstab"
fi
done
#### add special folder outside of /Server ####
sudo echo "# Mounted from HDA Peti" >> /etc/fstab
sudo echo "" >> /etc/fstab
sudo mkdir /mnt/Network/Peti
sudo echo "//192.168.1.250/Peti /mnt/Network/Peti cifs credentials=/home/ubuntu/.smbcredentials,iocharset=utf8 0 0" >> /etc/fstab
echo "Peti created and added to fstab"

### append to .smbcredentials file ###
sudo echo "username=$user" >> .smbcredentials
sudo echo "password=$pass" >> .smbcredentials
sudo chmod 600 .smbcredentials

### mount folders ###
sudo mount -a

### user feedback ###
echo "Finished!"
echo "HDA folders mounted in /mnt/Network/"

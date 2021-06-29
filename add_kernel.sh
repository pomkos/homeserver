#!/bin/bash

###################################################
# Function: automate common ubuntu setup tasks    #
# Tasks:                                          #
#   - Append fstab file                           #
#   - Create /mnt/Network/$folder folders         #
#   - Mount HDA smb folders to /mnt/Network/*     #
# Script using neatshell's template               #
# https://gist.github.com/neatshell/5283811       #
###################################################

###################################################
#                Settings to modify               #
###################################################
ubuntu_home='ubuntu'                                          # Username of ubuntu user
server_name='HDA'                                             # Used in success messages
ip=192.168.1.250                                              # IP of SMB server
remote_mount=Server                                           # Folder on SMB that all other nonpassword protected folders are in
local_mount=Network                                           # Folder in /mnt/ that all folders will be mounted to
special_folder='Peti'                                         # Password protected, outside the $remote_mount folder
declare -a smb_folders=("Backups" "Documents"                 # Not password protected, inside the $remote_mount folder
    "Downloads" "Dump" "Home Videos" "Imports" 
    "Matt Stuff" "Movies" "Music" "Pictures" 
    "Steven" "TV")
# NOTE: Folders with a space in them need to be manually added in if statements (see lines 128-142)

###################################################
#                neatshell template               #
###################################################
script="initiate_ubuntu"
#Declare the number of mandatory args
margs=2

# Common functions - BEGIN
function example {
    echo -e "example: sudo $script -u VAL -p VAL"
}

function usage {
    echo -e "usage: sudo $script MANDATORY [OPTION]\n"
}

function help {
  usage
    echo -e "NOTE: Requires sudo for accessing /etc/fstab and /mnt, along with chmod"
    echo -e "MANDATORY:"
    echo -e "  -u, --username  VAL  The username of '$special_folder' share on $server_name"
    echo -e "  -p, --password  VAL  The password of '$special_folder' share on $server_name"
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

###################################################
#                    Main Body                    #
###################################################
### install requirements ###
apt-get install cifs-utils -y

### append to fstab file and create folders###
#### initiate ####
echo "" >> /etc/fstab
echo "# Mounted from $server_name Main"  >> /etc/fstab
echo "" >> /etc/fstab
mkdir /mnt/$local_mount
#### folders ####
for folder in "${smb_folders[@]}";
do
#### folders with spaces ####
if [ "$folder" = "Home Videos" ]
then
    # Add to fstab
    echo "//$ip/$remote_mount/Home\040Videos /mnt/$local_mount/Home\040Videos cifs guest,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    echo "" >> /etc/fstab
    # make directory
    mkdir /mnt/$local_mount/"$folder"
    echo "$folder folder created and added to /etc/fstab"
    echo ""
elif [ "$folder" = "Matt Stuff" ]
then
    echo "//$ip/$remote_mount/Matt\040Stuff /mnt/$local_mount/Matt\040Stuff cifs guest,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    echo "" >> /etc/fstab
    mkdir /mnt/$local_mount/"$folder"
    echo "$folder folder created and added to /etc/fstab"
else
    echo "//$ip/$remote_mount/$folder /mnt/$local_mount/$folder cifs guest,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    echo "" >> /etc/fstab
    mkdir /mnt/$local_mount/"$folder"
    echo "$folder folder created and added to /etc/fstab"
fi
done
#### add special folder outside of /$remote_mount ####
echo "# Mounted from $server_name $special_folder" >> /etc/fstab
echo "" >> /etc/fstab
mkdir /mnt/$local_mount/$special_folder
echo "//$ip/$special_folder /mnt/$local_mount/$special_folder cifs credentials=/home/$ubuntu_home/.smbcredentials,iocharset=utf8 0 0" >> /etc/fstab
echo "$special_folder created and added to /etc/fstab"

### append to .smbcredentials file ###
echo "username=$user" >> .smbcredentials
echo "password=$pass" >> .smbcredentials
chmod 600 .smbcredentials

### mount folders ###
mount -a

### user feedback ###
echo "Finished!"
echo "$server_name folders mounted in /mnt/$local_mount/"

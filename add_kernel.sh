#!/bin/bash

###############################################
# Script using neatshell's template           #
# Function: add a python kernel to jupyterlab #
# https://gist.github.com/neatshell/5283811   #
###############################################

script="add_kernel"
#Declare the number of mandatory args
margs=2

# Common functions - BEGIN
function example {
    echo -e "example: $script -e my_env -d 'My Env'"
}

function usage {
    echo -e "usage: $script MANDATORY [OPTION]\n"
}

function help {
  usage
    echo -e "Adds a python kernel to the jupyterlab instance.\n"
    echo -e "MANDATORY:"
    echo -e "  -e, --env           str  Name of conda environment"
    echo -e "  -d, --display_name  str  What is shown inside JupyterLab"
    echo -e "OPTION:"
    echo -e "  -o, --os            str  What os is used. Accepts 'mac' (default) or 'ubuntu' as parameters."
    echo -e "  -h, --help               Prints this help\n"
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

env=       # default is empty
display=   # default is empty
os="mac"   # default option

# Args while-loop
while [ "$1" != "" ];
do
    case $1 in
   -e  | --env )          shift
                          env=$1
                		  ;;
   -d  | --display_env )  shift
   						  display=$1
			              ;;
   -h  | --help )         help
                          exit
                          ;;
   -o  | --os )           shift
                          os=$1
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
margs_check $env $display

# Your stuff goes here
if [ $os == "mac" ]; then
    echo "Assuming $os with miniconda"
    ~/opt/miniconda3/envs/$env/bin/python -m ipykernel install --user --name "$env" --display-name "$display"
else
    echo "Assuming $os with conda"
    ~/.conda/envs/$env/bin/python -m ipykernel install --user --name "$env" --display-name "$display"
fi
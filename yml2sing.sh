#/bin/bash

# This script execute a singularity build command to create a sing image from a yml file
# 
# Usage : create a folder containing a yml file and type un a terminal $ yml2sing.sh <image-name> 
# read my documentation about singularity https://github.com/kirsho/Singularity/blob/master/Intro2Singularity.md
# contact : Olivier Kirsh <olivier.kirsh@u-paris.fr>
# date : 20190923

# download my definition file for singularity
# For easy push in shubn the definition file is named Singularity
wget https://raw.githubusercontent.com/kirsho/Singularity/master/Singularity

# extract yml file name from work directory
defile="$(ls *.yml)"

# mofify the definition file (Singularity)
sed -i "s/env-name.yml/${defile}/g" Singularity

# Build the image
sudo singularity build --writable  $1.simg Singularity

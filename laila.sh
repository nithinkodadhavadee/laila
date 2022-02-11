#!/bin/bash

upgradeCommand="upgrade"
upgradeIgnore="/home/somannak/Scripts/laila/upgradeignore.txt"
flag=0

upgradeDir(){
	cd $1
	echo -e "\n\n\nUpgrading $1\n\n"
	git pull
	makepkg -sirc
}

if [ "$upgradeCommand" == "$1" ]; 
then
	# Updating the System
	echo -e "System Upgrade \n" 

	# Updating all the packages other than the one in upgradeignore.txt file
	sudo pacman -Syu
	for f in ~/applications/*; do
		if [ -d "$f" ]; 
		then
			flag=0
			while IFS= read -r line; do
				if [ "$f" == "$line" ]; 
				then
					flag=1
				fi
			done < "$upgradeIgnore"
			if [ $flag == 0 ]; then
				upgradeDir "$f"
			fi
		fi
	done
	# Upgrading Flutter
	flutter upgrade
else
	echo "Hey $1"
fi

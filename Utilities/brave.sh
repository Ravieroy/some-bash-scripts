#! /bin/bash

# Installation for Debian based distro : Ubuntu, popOS, mint

brave_install_ubuntu(){

brave-browser --version
if [ $? -eq 0 ]; then
    echo "Brave Browser already exists"
else
	
    echo "Starting process to install Brave Browser"
    sleep 1

    sudo apt install apt-transport-https curl

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    echo "Installing Brave: Almost done "

    sudo apt install brave-browser

    echo "Done!!!"
fi
}

# Complete removal of brave browser

brave_uninstall_ubuntu(){

brave-browser --version
if [ $? -eq 0 ]; then

    echo "This will completely remove your Brave installation:"
    sleep 0.5

    echo -e "Do you want to continue (Y/n)? : \c"
    read input
        if [ -z "$input" ]
        then
                input=Y
        fi
    case $input in
        "Y" | "y" )
        sudo apt -y remove brave-browser && sudo apt -y purge brave-browser && rm -rf ~/.config/BraveSoftware && rm -rf ~/.cache/BraveSoftware
        sudo apt autoremove
        echo "Uninstall complete" ;;
        "n" )
         brave-browser --version  ;;
    esac

else
    echo "Brave doesn't exist"
fi
}


function show_menu(){
date
echo "---------------------------"
echo " Main Menu"
echo "---------------------------"
echo "1. Install Brave for Debian/Ubuntu based distros"
echo "2. Completely remove Brave for Debian/Ubuntu based distros"
echo "3. Exit"
}



function read_input(){
local input
read -p "Enter your choice [ 1 -3 ] " input
case $input in
    1) brave_install_ubuntu ;;
    2) brave_uninstall_ubuntu ;;
    3) echo "Bye!"; exit 0 ;;
    *)
    echo "Please select from 1 to 3."
esac
}

message(){
    echo "This script has been tested for Debian/Ubuntu based distros. When you uninstall Brave using this script, no traces or previous settings will remain"
    echo "For other distros visit: https://brave.com/linux/ "
    echo " "
}

trap '' SIGINT SIGQUIT SIGTSTP

message
sleep 3
show_menu
read_input

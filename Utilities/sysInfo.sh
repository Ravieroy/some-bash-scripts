#! /bin/bash

# A simple shell script to show most common system information.
# You require acpi installed to display battery info. It would work either way
# Made by Ravi roy (https://github.com/ravieroy)

#This function checks for root access 

chk_root() {
	local meid=$(id -u)
	if [ $meid -ne 0 ]; then
		echo "You are not root user. This will work best if you are root."
		exit 999
    fi
}


#This installs acpi for battery info
install_acpi(){

if ! acpi; then
    echo -e " acpi needs to be installed to display battery information. Do you want to install (Y/n)? \c"
    read input
    if [ -z "$input" ]
    then
            input=Y
    fi
    case $input in
        "Y" | "y" )
        sudo apt -y install acpi
        echo "Install complete" ;;
        "N" | "n" )
         echo "Can't show battery info"  ;;
    esac
fi
}

# To check for empty slot in memory
mem_slot(){
lshw -short -C memory | grep -i empty
if [ $? -ne 0 ]; then
    echo "You do not have any empty memory slots"
else
	
    echo "You have empty memory slot"
fi
}

# This function contains all the process 

process(){

echo "--------------------------------------------------------------------------------------"
echo " "

dmidecode | grep -A4 '^System Information'  #provides system information

echo " "
echo "--------------------------------------------------------------------------------------" 


echo "System $(lscpu | grep -i architecture)"  # architecture 64 or 32 bits

echo " "
echo "--------------------------------------------------------------------------------------" 


echo "Battery : $(dmidecode | grep -i design\ capacity)" # battery capacity

if acpi; then
    echo " " 
else
    echo "acpi not found!! Can't display battery capacity. "
fi

echo " "
echo "---------------------------------------------------------------------------------------"


#echo "Screen Dimension: $(xdpyinfo | awk '/dimensions/{print $2}')" #Screen dimension
#xdpyinfo | grep resolution #Screen Resolution #DPI
echo "Screen Resolution and Refresh rate: $(xrandr | grep -i "\*") "



echo " "
echo "---------------------------------------------------------------------------------------"


echo $(dmidecode -t bios | grep -i installed\ language) #installed language

echo " "
echo "---------------------------------------------------------------------------------------"


echo "Installed OS $(lsb_release -a | grep -i description)" # OS version 

echo " "
echo "---------------------------------------------------------------------------------------"


lscpu | grep -i mhz #CPU maximum in mHz

echo " "
echo "------------------------------MAXIMUM MEMORY FOR HARDWARE------------------------------"


dmidecode -t memory | grep -i maximum\ capacity #max memory installable

echo " "
echo "---------------------------------------------------------------------------------------"

mem_slot # function to check if there is space for memory stick

echo " "
echo "--------------------------RAM INFO-----------------------------------------------------"

free -h --si  #current memory use

echo " "
echo "---------------------------------------------------------------------------------------"

echo "Your disk $(lshw -c disk | grep -i size:)" #Disk size

echo " "
echo "---------------------------------------------------------------------------------------"


dmidecode -t bios | grep -i release\ date # Release date 

echo " "
echo "---------------------------------------------------------------------------------------"


dmidecode -t bios | grep -i rom\ size #ROM Size

echo " "
echo "---------------------------------------------------------------------------------------"


dmidecode -t bios | grep -i usb\ legacy # is usb legacy supported

echo " "
echo "---------------------------------------------------------------------------------------"


dmidecode -t bios | grep -i uefi # is uefi supported 

echo " "
echo "----------------------------CPU--------------------------------------------------------"


lshw -C cpu | grep -i configuration # cores threads

echo " "
echo "---------------------------------------------------------------------------------------"


lshw -C cpu | grep -i product # Processor 

echo " "
echo "---------------------------------------------------------------------------------------"


echo "Your IP address for ssh connection is: $(hostname -I | awk '{print $1}') " # IP address 

echo " "
echo "---------------------------------------------------------------------------------------"


echo " ssh service status"
systemctl status ssh | grep -i active # ssh active/inactive

echo " "
echo "---------------------------------------------------------------------------------------"
}


chk_root
install_acpi
clear
process
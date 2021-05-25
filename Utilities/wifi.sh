#! /bin/bash
   
#For text colors
txtred=$(tput setaf 1)
txtgrn=$(tput setaf 2)
txtylw=$(tput setaf 3)
txtblu=$(tput setaf 4)
txtpur=$(tput setaf 5)
txtcyn=$(tput setaf 6)
txtrst=$(tput sgr0)

echo "${txtylw}Getting Wifi list${txtrst}"
nmcli -t -f ,ssid dev wifi > ssid.txt
nl ssid.txt
n_lines=$(wc -l < ssid.txt)
echo $n_lines
read -p "${txtgrn}Enter your choice: ${txtrst}" input
echo $input
wifi_name=$(sed -n -e "$input"p ssid.txt)
echo "${txtylw}Connecting "$wifi_name" ...${txtrst}"

nmcli d wifi connect $wifi_name --ask
rm ssid.txt
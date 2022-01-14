#!/bin/bash
# Ravi Roy (https://github.com/Ravieroy)

#For text colors(Only for aesthetics)
clear
txtred=$(tput setaf 1)
txtgrn=$(tput setaf 2)
txtylw=$(tput setaf 3)
txtblu=$(tput setaf 4)
txtpur=$(tput setaf 5)
txtcyn=$(tput setaf 6)
txtrst=$(tput sgr0)

#Syntax error message 

if [ $# -eq 0 ]
then
    echo "${txtred}Error : Wrong Syntax${txtrst}"
    echo "${txtcyn}---------------------------${txtrst}"
    echo "${txtylw}n : number of random points${txtrst}"
    echo "${txtcyn}---------------------------${txtrst}"
    echo "${txtgrn}Syntax:${txtcyn} $0 n"
    exit 999
fi

#Generates random number between 0 and 1
#Following will generate n random numbers in range[0,1) with 5 decimal digits
# awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.4f\n", rand()) }'

generate_random_number(){
    x=$(awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); printf("%.5f\n", rand()) }')
    y=$(awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); printf("%.5f\n", rand()) }')
}

for var in $(seq $1)
    do
        generate_random_number
        r=$(echo "scale=5; sqrt(($x*$x)+($y*$y))" | bc)
        if (( $(echo "$r <= 1" |bc ) )); then
        inside=$((inside+1))
        fi    
        total=$((total+1))
    done

pi=$(echo "scale=5; 4*a(1)" | bc -l)
pi_num=$(echo "scale=5; $inside*4/$total " | bc)
err=$(echo "scale=5; $pi - $pi_num " | bc)

echo "${txtcyn}----------------------------------------${txtrst}"
echo "${txtylw}Calculated Value:${txtrst} $pi_num ${txtgrn}Error:${txtrst} $err"
echo "${txtcyn}----------------------------------------${txtrst}"


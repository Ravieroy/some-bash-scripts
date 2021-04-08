#! /bin/bash

#This script takes file name as argument and  checks if the file is executable or not.

if [ $# -eq 0 ]
then
    echo "Error : Wrong usage"
    echo "usage: $0 fileName"
else 
    if [ -e $1 ]
    then 
        if [ -x $1 ] # -e is for file exist or not
        then
        echo "$1 is an executable"
        else
        echo "$1 is  not an executable"
        fi
    else
    echo "$1 not found"
    fi
fi

#!/bin/bash

has_SS=0
has_s=0

for arg in $@;
do
    if [[ "${arg:0:1}" == "-" ]]
    then
        case $arg in 
        --) break
            ;;
        -s) has_s=1
            ;;
        -S) has_SS=1
            ;;
        --usage)    
            echo "$0 [-s] [-S] arg..."
            exit 0
            ;;
        -*) echo "Invalid option: $arg"
            exit 2
            ;;
        esac
    fi
done

S=0
mis=0
for arg in "$@"; 
do
    if [[ "$arg" == "--" ]]; then
        sep=1
    elif [[ "$sep" == 1 || "${arg:0:1}" != "-" ]]
    then
        if [[ ! -f "$arg" ]]; then 
            echo "no such file \"$arg\"" >&2
            mis=1
            continue;
        fi
        a=$(stat --format %s -- "$arg")
        S=$(($a + $S))                
        if [[ "$has_SS" == 0 ]]; then
            echo $a: $arg
        fi
    fi
done



if [[ "$has_SS" == 1 || "$has_s" == 1 ]]; then
    echo $S
fi

if [[ $mis -eq 1 ]]; then    
    exit 1
fi
        


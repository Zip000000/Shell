#!/bin/bash

function is_run() {
if [[ $[ $1%400 ] -eq 0 ]]; then
    echo 1
fi

if [[ $[ $1%4 ] -eq 0 ]]; then
    if [[ $[ $1%100 ] -ne 0 ]]; then
        echo 1
    fi
fi  
echo -1
}


sum=0

for i in $(seq $1 $2)
do
    if [[ $(is_run $i) -eq -1 ]]; then
        sum=$[ ${sum} + 365 ]
    else
        sum=$[ ${sum} + 366 ]
    fi
done

echo ${sum}


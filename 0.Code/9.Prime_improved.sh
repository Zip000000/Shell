#!/bin/bash


for((temp = 0; temp<=1000; temp++));
do
    arr[${temp}]=1
done

arr[1000]=1 
arr[0]=0
arr[1]=0
arr[2]=1
#0 已经被标记了
#1 质数或者未标记



for((i = 1; $[ i*i ] <= 1000; i++));
do
    if [[ ${arr[$i]} -eq 0 ]]; then
        continue
    fi

    for((j = i; j <= 1000; j++));
    do
        arr[$[$i * $j]]=0
    done
    
done

sum=0

for((k = 2; k <= 1000; k++));
do
    if [[ ${arr[$k]} -eq 1 ]]; then
        printf "%d\n" $k
        sum=$[ sum + $k ]
    fi
done

echo ${sum}

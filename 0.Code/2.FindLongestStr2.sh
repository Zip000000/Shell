#!/bin/bash

max=0
strnum=0
filenum=0

function Fliter() {
    FliterFile=$1
    file ${FliterFile} | grep -q -w "text"
    echo $?
}

function findinfile() {
    #echo "$1 Fliter1 = $(Fliter $1)"
    if [[ $(Fliter $1) -eq 1 ]]; then
        return
    fi
    filenum=$[${filenum}+1]
    for i in `cat $1 | tr -c "a-zA-Z" "\n" | grep [^$] `
    do
        cnt=${#i}
        if [[ max -lt cnt ]]; then
            max=${cnt}
            maxstr=$i
        fi 
        #echo "File.$filenum No.${strnum} max=$max maxstr=$maxstr"
        strnum=$[${strnum}+1]
    done
}

function findindir() {
    local cwd="$1/"
    for i in `ls -A $1` 
    do
        if [[ -f ${cwd}${i} ]]; then
            #echo -n "file:  ${cwd}${i} :"
            findinfile ${cwd}${i}   
        elif [[ -d ${cwd}${i} ]]; then
            #echo -n "dir:  ${cwd}${i} :"
            findindir "${cwd}${i}/"
        else
            echo ${cwd}${i}
            echo "oops!"
        fi
    done
}

function startfind() {
    echo -e ""
    echo "$1 :"
    findindir "$1"
    echo "一共搜寻了 $filenum 个文件，$strnum 个字符串。"
    echo -n "其中最长的字符串为："
    echo -e "\033[1;31m$maxstr\033[0m" 
    echo -n "长度为："
    echo -e "\033[1;31m$max\033[0m"
    max=0
    strnum=1
    filenum=1
}

function parameter_judge() {
    echo -e "\033[44;37m 开始搜索最长字符串 \033[0m" 
    if [[ -z $1 ]]; then
        startfind "."
    else
        for i in $@
        do
            startfind "$i"
        done
    fi

}

parameter_judge $@

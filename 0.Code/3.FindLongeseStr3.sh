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
        strnum=$[${strnum}+1]
    done
}

function findindir() {
    local cwd="$1/"
    for i in `ls -A $1` 
    do
        if [[ -f ${cwd}${i} ]]; then
            findinfile ${cwd}${i}   
        elif [[ -d ${cwd}${i} ]]; then
            findindir "${cwd}${i}/"
        else                        #没用了
            echo ${cwd}${i}    
            echo "oops!"
        fi
    done
}

function startfind() {
    max=0
    strnum=0
    filenum=0
    echo ""
    if [[ -f $1 ]]; then
        echo -n -e "\033[32m[File]  \033[0m" 
        findinfile $1
    elif [[ -d $1 ]]; then
        echo -n -e "\033[32m[Dir]   \033[0m" 
        findindir "$1"
    fi

    echo -e "\033[34m$1\033[0m :"
    echo "一共搜寻了 $filenum 个文件，$strnum 个字符串。"
    echo -n "其中最长的字符串为："
    echo -e "\033[1;31m$maxstr\033[0m" 
    echo -n "长度为："
    echo -e "\033[1;31m$max\033[0m"
}

function finderror() {
    for i in $@
    do
        if [[ -f $i || -d $i ]]; then
            :    #空语句
        else
            echo "findlongest: ${i}: 没有那个文件或目录!" 1>&2
            exit 1
        fi
    done
}

function parameter_judge() {
    finderror $@
    echo ""
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

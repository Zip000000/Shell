#!/bin/bash

max=0
strnum=0
filenum=0
fromwhere="没有文件"

function Fliter() {
    FliterFile=$1
    file ${FliterFile} | grep -q -w "text"
    echo $?
}

function findinfile() {
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
            fromwhere=$1
        fi 
        strnum=$[${strnum}+1]
    done
}

function findindir() {
    local cwd="$1/"

    ls $1 1>/dev/null 2>/dev/null
    
    if [[ $? -ne 0 ]]; then
        return
    fi

    for i in `ls -A $1` 
    do
        if [[ -f ${cwd}${i} ]]; then
            findinfile ${cwd}${i}   
        elif [[ -d ${cwd}${i} ]]; then
            findindir "${cwd}${i}/"
        else                        
            :
            #echo ${cwd}${i}    
            #echo "oops!"
        fi
    done
}

function startfind() {
    max=0
    strnum=0
    filenum=0
    echo ""
    if [[ -f $1 ]]; then
        echo -n -e "\033[1;33m[File]  \033[0m" 
        echo -e "\033[1;36m$1\033[0m :"
        findinfile $1
    elif [[ -d $1 ]]; then
        echo -n -e "\033[1;33m[Dir]   \033[0m" 
        echo -e "\033[1;36m$1\033[0m :"
		
#		for((i=0;i<=10;i++));do
#		{
#		    echo -en "\b"
#		    echo -en "$i"
#		    sleep 0.5
#		}&
#		done        
		
        findindir "$1"
    fi

     
    
    echo "一共搜寻了 $filenum 个文件，$strnum 个字符串。"
    echo -n "其中最长的字符串为："
    echo -e "\033[1;35m$maxstr\033[0m" 
    echo -n "来自文件："
    echo -e "\033[1;35m$fromwhere\033[0m"
    echo -n "长度为："
    echo -e "\033[1;35m$max\033[0m"
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
    echo -e "       \033[1;42;37m 搜索最长字符串 \033[0m" 
    if [[ -z $1 ]]; then
        startfind "."
    else
        for i in $@
        do
            startfind "$i"
        done
    fi
    echo ""

}


#echo -en "\033[?25l"
parameter_judge $@
#echo -e "\033[?25h"



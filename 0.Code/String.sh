#!/bin/bash

#str[0] > [1] > [2]  保存字符串
#fname[0] > [1] > [2]  保存来自哪儿
str=( 0 0 0 )
fname=( 0 0 0 )
line=( 0 0 0 )

function Fliter() {
    FliterFile=$1
    file ${FliterFile} | grep -q -w "text"
    echo $?
}

#filter_conf=./filter.conf

#function filter() {
#	file_type=`basename $1 | tr [.] "\n" | tail -1`
#	grep -w ${file_type}  ${filter_conf}
#	if [[ $? -eq 0 ]]; then
#		file $1 | grep -q -w "text"
#		if [[ $? -eq 0 ]]; then
#			return 1
#		else
#			return 0
#		fi
#	else
#		return 1
#	fi
#}

function findinfile() {
    for i in `seq 0 2`
    do
        if [[ $1 -ef ${fname[$i]} ]]; then
            return
        fi
    done

    if [[ $(Fliter $1) -eq 1 ]]; then
        return
    fi
    
    for i in `cat $1 | tr -c -s "a-zA-Z" "\n"  `
    do
        cnt=${#i}
        
        if [[ ${cnt} -ge ${#str[0]} ]]; then
            str[2]=${str[1]}
            str[1]=${str[0]}
            str[0]=$i
            fname[2]=${fname[1]}
            fname[1]=${fname[0]}
            fname[0]=$1
        elif [[ ${cnt} -ge ${#str[1]} ]]; then
            str[2]=${str[1]}
            str[1]=$i
            fname[2]=${fname[1]}
            fname[1]=$1
        elif [[ ${cnt} -ge ${#str[0]} ]]; then
            str[2]=$i
            fname[2]=$1
        else
            continue
        fi
        
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
            findindir "${cwd}${i}"
        else                        
            :
        fi
    done
}

function startfind() {
    if [[ -f $1 ]]; then
        findinfile $1
    elif [[ -d $1 ]]; then
        findindir "$1"
    fi
}

function finderror() {
    for i in $@
    do
        if [[ -f $i || -d $i ]]; then
            :    #空语句
        else
            exit 1
        fi
    done
}

function parameter_judge() {
    finderror $@
    if [[ -z $1 ]]; then
        exit 1
    else
        for i in $@
        do
            startfind "$i"
        done
    fi
    
    for i in `seq 0 2`
    do
        line=`grep -n -w  ${str[$i]} ${fname[$i]} 2>/dev/null | head -n 1 | cut -d ":" -f 1 `
        echo "${#str[$i]}:${str[$i]}:${fname[$i]}:${line}"
    done

}


# $1 当前文件  $2 起始位置
function Issamefile() {
    for (( x=$2; x<=${allparanum}; x++ )); do
        if [[ $1 -ef  ${allpara[${x}]} ]]; then
            return 1 #跳过
        fi
    done
    return 0 #可以进行查找
}

for i in $@; do
    allpara+=($i)
done
allparanum=$#
parameter_judge $@



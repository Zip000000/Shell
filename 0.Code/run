#!/bin/bash
if [[ $# -lt 1 ]]; then
    echo "【run】 您没有输入参数" 
    exit 1
fi

if [[ $# -gt 1 ]]; then
    echo "【run】 run功能目前仅支持一个参数" 
    exit 1
fi

g++ $1 && ./a.out && rm a.out

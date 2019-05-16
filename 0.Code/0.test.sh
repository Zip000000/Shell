#!/bin/bash

function print() {
    ${1}="aaa"
    ${2}="bbb"

    for i in $@
    do 
        echo "x = $i"
    done
}

print $@

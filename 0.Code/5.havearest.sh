#!/bin/bash

    starttime=$(date +%s)

while [[ true ]] {
    export DISPLAY=:0.0 && notify-send "开始工作了，45分钟后我会提醒您休息。"
    
    nowtimemin=$(date +%M)

    if [[ ${nowtime} -eq 0 ]]
        do
            nowtimehour=$(date +%H)
            echo "现在 ${nowtimehour} 点啦！"
        done
    if

    nowtime=$(date +%s)
    pasedtime=$[$[${nowtime}-${starttime}]/60]

    if [[ 45fenzhongdaole  ]]
        do
            echo "xiuxi"
            sleep(5m)
        done
    fi
    
        sleep(一分钟)
}



# export DISPLAY=:0.0 && notify-send "HI"


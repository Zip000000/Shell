#!/bin/bash

    starttime=$(date +%s)

while true 
do
    export DISPLAY=:0.0 && notify-send "开始工作了，45分钟后我会提醒您休息。"
    sleep 1m
    nowtime=$(date +%s)
    minnow=$(date +%M)
    hournow=$(date +%H)
    pasedtime=$[$[${nowtime}-${starttime}]/60]
    if [[ ${minnow} -eq 0 ]]; then
        export DISPLAY=:0.0 && notify-send "现在 ${hournow} 点啦!"
    fi


    if [[ ${pasedtime} -eq 1 ]]; then
        export DISPLAY=:0.0 && notify-send "您已经连续工作四十五分钟了！现在请您休息五分钟吧！五分钟后我会提醒您"
        sleep 5m
        export DISPLAY=:0.0 && notify-send "五分钟到啦！现在您可以继续工作了，四十五分钟之后我会提醒您休息"
        starttime=$(date +%s)
    fi
done



# export DISPLAY=:0.0 && notify-send "HI"


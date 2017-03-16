#!/bin/bash

cro=/etc/crontab
n=`netstat -ntpl | grep nginx`
p=`netstat -ntpl | grep php-fpm`
r=`netstat -ntpl | grep redis-server`


if [[ `cat $cro | grep jincheng` ]];then
   echo "1"
else
   echo -n "0"; read
   sed -i '$a */1 * * * * root bash /usr/local/shell/jincheng.sh' /etc/crontab
   echo "守护进程已写入/etc/crontab"
fi

function jc ()
{
    if [[ $n ]];then
    echo "nginx正在运行"
    else
    /usr/local/nginx-1.8.0/sbin/nginx -c /usr/local/nginx-1.8.0/conf/nginx.conf
    echo "nginx开始运行"
    fi

    if [[ $p ]];then
    echo "php正在运行"
    else
    /usr/local/php-7.1.0/sbin/php-fpm
    echo "php开始运行"
    fi

    if [[ $r ]];then
    echo "redis正在运行"
    else
    /usr/local/redis-2.8.17/bin/redis-server /etc/redis-2.8.17/redis.conf &
    echo "redis开始运行"
    fi
}
jc


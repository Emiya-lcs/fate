#!/bin/bash

echo "---------------------------------------"
echo "|----------1、增加端口转发------------|"
echo "|----------2、删除端口转发------------|"
echo "---------------------------------------"

#选择增加还是删除端口转发
while true
do
    echo -n "选择"
    read xz
    case $xz in
    1)
    shift
#获取输入的变量
function duankou1()
{
  #原端口
  echo -n "输入原端口号:"
  read sdk
  #转发的端口
  echo -n "输入转发的端口:"
  read ddk
  while true
  do
  #转发的ip
  echo -n "是否需要转发的原ip地址[Y/N]"
   read ip
  case $ip in
   Y)
   shift
  echo -n "输入ip:"
  read addr
   shift
   ;;
   N)
  shift
  echo "No"
   shift
   ;;
  esac
  break 
  done
  #添加变量到规则里
  firewall-cmd --add-forward-port=port=$ddk:proto=tcp:toport=$sdk:toaddr=$addr --permanent
  firewall-cmd --reload
  echo "端口是"$ddk,$sdk
}
duankou1
    shift
    ;;

    2)
    shift
#获取输入的变量
function duankou2()
{
  #原本的端口
  echo -n "输入删除原端口号:"
  read sdk
  #转发的端口
  echo -n "输入删除转发的端口号:"
  read ddk
  
  #添加变量进规则
  firewall-cmd --remove-forward-port=port=$ddk:proto=tcp:toport=$sdk --permanent
  firewall-cmd --reload
}
duankou2
   shift
   ;;
 esac
break
done

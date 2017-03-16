#!/bin/bash
#CentOS7防火墙禁止特定IP访问
fws=`firewall-cmd --state`

#判断firewall是否运行

function fw ()
{
	if [[ $fws == "running" ]];then
		echo "firewall已运行"
echo "---------------------------------------------------"
echo "|---------------1、禁止特定IP访问-----------------|"
echo "|---------------2、解除特定IP访问-----------------|"
echo "---------------------------------------------------"
	
while true
do
	echo -n "请做出你的选择:"
	read xz

	case $xz in
		1)
          shift
          echo -n "输入你需要禁止的IP:"
          read ip
          function a1
          {
          	firewall-cmd --permanent --add-rich='rule family=ipv4 source address="'$ip'" drop'
          	#firewall-cmd --reload
          }
          a1
          echo $ip"已禁止"
          shift
          ;;
        2)
          shift
          echo -n "输入你需要解除的IP:"
          read ip
          function a2
          {
          	firewall-cmd --permanent --remove-rich='rule family=ipv4 source address="'$ip'" drop'
          	#firewall-cmd --reload
          }
          a2
          echo $ip"已解除"
          shift
          ;;
    esac
    break
done

#重启firewall服务
function cq
{
	echo -n "重启firewall服务使其生效，是否重启[Y/N]"
	read cqq
	case $cqq in
		Y)
        shift
	firewall-cmd --reload
	    shift
	    ;;
	    N)
        shift
        echo "记得稍后重启firewall服务"
        ;;
    esac
}
cq

else
		echo "firewall未运行，请运行firewall"
	fi
}
fw

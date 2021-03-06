#!/bin/bash

qd_dir=/etc/rc.d/init.d
qd001_dir=/etc/rc.d/init.d/qd001.sh


#开机启动PHP+Nginx+redis
echo "------------------------------------------------------"
echo "|------------1、使用春生的LNMP脚本请选1--------------|"
echo "|-------------------2、不是请选2---------------------|"
echo "------------------------------------------------------"

while true
do
   echo -n "请选择："
   read xz
   case $xz in
    1)
    shift
#脚本路径
php_path=/usr/local/php-7.1.0/sbin/php-fpm
nginx_path=/usr/local/nginx-1.8.0/sbin/nginx
#redis_path=echo -e "\n" | /usr/local/redis-2.8.17/bin/redis-server /etc/redis-2.8.17 &
#memcached_path=/usr/local/memcached-1.4.15/bin/memcached -u root -d

    shift
    ;;
    2)
    shift
php_path=`find / -path */sbin/php-fpm` 
nginx_path=`find / -path */sbin/nginx` 
redis_path=`find / -path */bin/redis-server` 
memcached_path=`find / -path */bin/memcached`
    shift
    ;;
    esac
    break
    done
#判断启动脚本是否创建
if [ -f $qd001_dir ];then
	echo '已创建:'$qd001_dir
else


#创建启动脚本
function qidong1
{
	touch $qd_dir/qd001.sh
	chmod +x $qd_dir/qd001.sh
}
qidong1


#启动脚本函数
function qidong2
{
	echo '#!/bin/bash' > $qd_dir/qd001.sh
	sed -i '$a #chkconfig:2345 80 90
	        $a #description:auto_run
	        $a
	        $a #nginx启动
	        $a '$nginx_path'
	        $a
	        $a #php启动
	        $a '$php_path'
	        $a
	        $a #redis启动
	        $a echo -e "\n" | '$redis_path' /etc/redis-2.8.17 &
	        $a
	        $a #memcached启动
	        $a '$memcached_path' -u root -d' $qd_dir/qd001.sh
	echo "参数已写入脚本"
}
qidong2
fi

echo "-------------------------------------------"
echo "|------------a、设置开机自启--------------|"
echo "|------------b、取消开机自启--------------|"
echo "-------------------------------------------"

while true
do
  echo -n "请做出你的选择:"
  read xuanze
  echo $xuanze
  case $xuanze in
  	a)
    shift
    #需要执行的函数
function qidong3
{
	cd $qd_dir
	chkconfig --add qd001.sh
	chkconfig qd001.sh on
}
qidong3
  echo "设置自启成功"
  shift
  ;;

  b)
  shift
  #需要执行的函数
function qidong4
{
	cd $qd_dir
	chkconfig --del qd001.sh
	chkconfig qd001.sh off
}
qidong4
  echo "取消开机自启"
  shift
  ;;
esac
break
done

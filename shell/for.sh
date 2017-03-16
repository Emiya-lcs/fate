#!/bin/bash

i=`ls /usr/local`
for file in $i
do
   if [ -d $file ];then
     echo "6"
   else
     echo "7"
   fi
done

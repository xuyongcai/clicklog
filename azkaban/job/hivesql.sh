#!/bin/bash

#set java env
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

#set hadoop env
export HADOOP_HOME=/Users/xuyongcai/hadoop/hadoop-2.9.0
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH

export HIVE_HOME=/Users/xuyongcai/hadoop/apache-hive-2.3.4-bin
export PATH=${HIVE_HOME}/bin:$PATH


#linux上操作date格式
#day_01=`date -d'-1 day' +%Y-%m-%d`
#syear=`date --date=$day_01 +%Y`
#smonth=`date --date=$day_01 +%m`
#sday=`date --date=$day_01 +%d`

#mac上操作date格式
day_01=`date -v-1d +%Y-%m-%d`
syear=`date -j -f %Y-%m-%d $day_01 +%Y`
smonth=`date -j -f %Y-%m-%d $day_01 +%m`
sday=`date -j -f %Y-%m-%d $day_01 +%d`


clean_dir=/cleaup/clickLog/$syear/$smonth/$sday

HQL_create_table="create table if not exists clicklog.accesslog(ip string,day string,url string,upflow string) row format delimited fields terminated by ','"

HQL_origin="load data inpath '$clean_dir' into table clicklog.accesslog"
#HQL_origin="create external table clicklog.accesslog(ip string,day string,url string,upflow string) row format delimited fields terminated by ',' location '$clean_dir'"
#echo $HQL_origin

hive -e  "$HQL_create_table"

hive -e  "$HQL_origin"






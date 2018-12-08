#!/bin/bash

#set java env
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

#set hadoop env
export HADOOP_HOME=/Users/xuyongcai/hadoop/hadoop-2.9.0
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH


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

log_hdfs_dir=/data/clickLog/$syear/$smonth/$sday
#echo $log_hdfs_dir

#数据清理的驱动类
click_log_clean=com.xiaochai.clicklog.AccessLogDriver

clean_dir=/cleaup/clickLog/$syear/$smonth/$sday

echo "hadoop jar /home/centos/hivedemo/hiveaad.jar $click_log_clean $log_hdfs_dir $clean_dir"
hadoop fs -rm -r -f $clean_dir
hadoop jar /Users/xuyongcai/IdeaProjects/clicklog/target/clicklog-1.0.jar $click_log_clean $log_hdfs_dir $clean_dir





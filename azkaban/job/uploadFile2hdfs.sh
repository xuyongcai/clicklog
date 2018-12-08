#!/bin/bash

#set java env
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

#set hadoop env
export HADOOP_HOME=/Users/xuyongcai/hadoop/hadoop-2.9.0
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH


#   1、先将需要上传的文件移动到待上传目录
#	2、在讲文件移动到待上传目录时，将文件按照一定的格式重名名


#日志文件存放的目录
log_src_dir=/Users/xuyongcai/Documents/azkaban_jobs/clicklog/log/

#待上传文件存放的目录
log_upload_dir=/Users/xuyongcai/Documents/azkaban_jobs/clicklog/upload_log/


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

#echo $day_01
#echo $syear
#echo $smonth
#echo $sday

#日志文件上传到hdfs的根路径
hdfs_root_dir=/data/clickLog/$syear/$smonth/$sday

hadoop fs -mkdir -p $hdfs_root_dir


#打印环境变量信息
echo "envs: hadoop_home: $HADOOP_HOME"

ls $log_src_dir | while read filename
do
	if [[ "$filename" == access.log ]]; then
		date=`date +%Y_%m_%d_%H_%M_%S`
		#将文件移动到待上传目录并重命名
		#打印信息
		echo "moving $log_src_dir$filename to $log_upload_dir"xxxxx_click_log_$filename"$date"
		mv $log_src_dir$filename $log_upload_dir"xxxxx_click_log_$filename"$date
		#将待上传的文件path写入一个列表文件willDoing
		echo $log_upload_dir"xxxxx_click_log_"$filename$date >> $log_upload_dir"willDoing."$date
	fi
done

#找到列表文件willDoing
ls $log_upload_dir | grep will | grep -v "_COPY_" | grep -v "_DONE_" | while read line
do
	#打印信息
	echo "toupload is in file:"$line
	#将待上传文件列表willDoing改名为willDoing_COPY_
	mv $log_upload_dir$line $log_upload_dir$line"_COPY_"
	#读列表文件willDoing_COPY_的内容（一个一个的待上传文件名）  ,此处的line 就是列表中的一个待上传文件的path
	cat $log_upload_dir$line"_COPY_" | while read line
	do
		#打印信息
		echo "puting...$line to hdfs path.....$hdfs_root_dir"
		hadoop fs -put $line $hdfs_root_dir
	done	
	mv $log_upload_dir$line"_COPY_"  $log_upload_dir$line"_DONE_"
done




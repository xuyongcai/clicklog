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

export SQOOP_HOME=/Users/xuyongcai/hadoop/sqoop-1.4.7.bin__hadoop-2.6.0
export PATH=${SQOOP_HOME}/bin:$PATH

sqoop export --connect \
 jdbc:mysql://localhost:3306/clicklog \
 --username root --password 17307867 --table upflow --export-dir \
/user/hive/warehouse/clicklog.db/upflow --input-fields-terminated-by ','


# clicklog
电视采集项目，基于nginx产生的日志进行数据处理，运用到mapreduce，hive，sqoop，azkaban（工作流调度），shell命令等。

# 运行步骤
1.把log目录下的日志move到待上传目录upload_log中，并按时间改名
  
2.把待上传目录upload_log到日志上传到hdfs

3.运用mapreduce取hdfs上的文件的“ip,day,url,upflow”字段，存到/cleanup/XXX目录中（数据清理）

4.运用hive，把清理好的文件存进clicklog.accesslog表中

5.运用hive操作，处理clicklog.accesslog表，得到clicklog.upflow表（含ip，sum（upflow））字段

6.运用sqoop，把hive中clicklog.upflow表的数据存进mysql中


# 工作流（xxx.job）
upload->clean->hivesql->ip->mysql


# 快速运行
1.用mysql数据库创建clicklog.upflow表，字段：（ip string, sum string）

2.把access.log文件copy到log目录下

3.运行job里的脚本(打包使用文件放到azkaban运行)

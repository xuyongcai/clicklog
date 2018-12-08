package com.xiaochai.clicklog;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;

/**
 * @author: xiaochai
 * @create: 2018-12-08
 **/
public class AccessLogDriver {

    public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
        DateToNUM.initMap();
        Configuration conf = new Configuration();
        if (args.length != 2){
            args = new String[2];
            args[0] = "hdfs://localhost/data/clickLog/20181208/";
            args[1] = "hdfs://localhost/cleaup/clickLog/20181208/";
        }

        Job job = Job.getInstance(conf);
        job.setJarByClass(AccessLogDriver.class);

        //设置mapper相关
        job.setMapperClass(AccessLogPreProcessMapper.class);
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(NullWritable.class);

        //设置reducer相关
        job.setNumReduceTasks(0);

        //为job设置输入输出路径
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        //运行job
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}

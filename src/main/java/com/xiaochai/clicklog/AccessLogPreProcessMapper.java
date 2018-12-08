package com.xiaochai.clicklog;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

/**
 * @author: xiaochai
 * @create: 2018-12-08
 **/
public class AccessLogPreProcessMapper extends Mapper<LongWritable, Text, Text, NullWritable> {

    Text text = new Text();

    @Override
    protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String vals[] = value.toString().split(" ");
        if (vals.length < 11){
            return;
        }
        String ip = vals[0];
        String date = AnalysisNginxTool.nginxDateStmpToDate(vals[3]);
        String url = vals[6];
        String upFlow = vals[9];

        text.set(ip + "," + date + "," + url + "," + upFlow);
        context.write(text,NullWritable.get());
    }
}

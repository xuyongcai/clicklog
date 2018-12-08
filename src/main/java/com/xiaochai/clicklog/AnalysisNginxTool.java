package com.xiaochai.clicklog;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AnalysisNginxTool
{
	private static Logger logger = LoggerFactory.getLogger(AnalysisNginxTool.class);

	public static String nginxDateStmpToDate(String date)
	{
		String res = "";
		try
		{
			SimpleDateFormat df = new SimpleDateFormat("[dd/MM/yyyy:HH:mm:ss");
			String datetmp = date.split(" ")[0].toUpperCase();
			String mtmp = datetmp.split("/")[1];
			DateToNUM.initMap();
			datetmp = datetmp.replaceAll(mtmp, (String) DateToNUM.map.get(mtmp));
            System.out.println(datetmp);
			Date d = df.parse(datetmp);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			res = sdf.format(d);
		}
		catch (ParseException e)
		{
			logger.error("error:" + date, e);
		}
		return res;
	}

	public static long nginxDateStmpToDateTime(String date)
	{
		long l = 0;
		try
		{
			SimpleDateFormat df = new SimpleDateFormat("[dd/MM/yyyy:HH:mm:ss");
			String datetmp = date.split(" ")[0].toUpperCase();
			String mtmp = datetmp.split("/")[1];
			datetmp = datetmp.replaceAll(mtmp, (String) DateToNUM.map.get(mtmp));

			Date d = df.parse(datetmp);
			l = d.getTime();
		}
		catch (ParseException e)
		{
			logger.error("error:" + date, e);
		}
		return l;
	}
}

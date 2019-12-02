package com.zwh.util;

import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.EncoderException;
import it.sauronsoftware.jave.MultimediaInfo;

import java.io.File;

public class MyVideoUtil {
    public static String getVideoTime(File source) {
        Encoder encoder = new Encoder();
        MultimediaInfo m = null;
        try {
            m = encoder.getInfo(source);
        } catch (EncoderException e) {
            e.printStackTrace();
        }
        long ms = m.getDuration();
        int ss = 1000;
        int mi = ss * 60;
        int hh = mi * 60;
        int dd = hh * 24;

        long day = ms / dd;
        long hour = (ms - day * dd) / hh;
        long minute = (ms - day * dd - hour * hh) / mi;
        long second = (ms - day * dd - hour * hh - minute * mi) / ss;

        String strHour = hour < 10 ? "0" + hour : "" + hour;//小时
        String strMinute = minute < 10 ? "0" + minute : "" + minute;//分钟
        String strSecond = second < 10 ? "0" + second : "" + second;//秒
        if (strHour.equals("00")) {
            return strMinute + "分" + strSecond + "秒";
        } else {
            return strHour + "时" + strMinute + "分" + strSecond + "秒";
        }
    }

}

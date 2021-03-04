import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/7
/// 版权： 江苏远大信息股份有限公司

class AqiUtils {

   static String getAQIGrade(String num){
    if (num == null||num == ""){
      return "无数据";
    }
    int tmp = int.parse(num);
    if (tmp<0){
      return "无数据";
    }else if (tmp<=50){
      return "优";
    }else if (tmp<=100){
      return "良";
    }else if (tmp<=150){
      return "轻度污染";
    }else if (tmp<=200){
      return "中度污染";
    }else if (tmp<=300){
      return "重度污染";
    }else{
      return "严重污染";
    }
  }

   static Color getAQIColor(String num){
      if (num == null||num == ""){
        return Color(0xff7a7a7a);
      }
      int tmp = int.parse(num);
       if (tmp<0){
         return Color(0xff7a7a7a);
       }else if (tmp<=50){
         return Color(0xff08DE04);
       }else if (tmp<=100){
         return Color(0xffFFD002);
       }else if (tmp<=150){
         return Color(0xffFC8000);
       }else if (tmp<=200){
         return Color(0xffFA000F);
       }else if (tmp<=300){
         return Color(0xff9A0048);
       }else{
         return Color(0xff710624);
       }
   }

}
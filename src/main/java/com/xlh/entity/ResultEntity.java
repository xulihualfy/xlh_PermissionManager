package com.xlh.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultEntity<T> {

    private  static final String SUCCESS="SUCCESS";//"处理成功";
    private  static final String FAILED="FAILED";//"处理失败";
    private  static final String NO_MSG="NO_MSG";//"没有提示信息";


    private  String state;//状态

    private  String msg;//返回的消息

    private   T t;//返回的数据

    //定义一个公共的方法。用来返回页面信息（返回这个对象),没有消息

    public  static <T> ResultEntity<T> success_msg(String msg){

        return new ResultEntity<T>(SUCCESS,msg,null);
    }

    //失败时调用
    public static <T> ResultEntity<T> failed_msg(String msg) {

        return  new ResultEntity<T>(FAILED,msg,null);
    }
}

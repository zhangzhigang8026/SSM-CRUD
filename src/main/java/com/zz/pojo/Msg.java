package com.zz.pojo;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //状态码 200-成功 400- 失败
    private int code;
    //提示信息
    private String msg;
    //返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg result =new Msg();
        result.setCode(200);
        result.setMsg("处理成功");
        return result;
    }
    public static Msg fail(){
        Msg result =new Msg();
        result.setCode(400);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public String getMsg() {
        return msg;
    }

}

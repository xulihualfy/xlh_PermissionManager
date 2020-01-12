package com.xlh.util;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

public class getMD5 {

    public static void main(String[] args) {
        //盐值
        Object bytes = ByteSource.Util.bytes("明明");
        SimpleHash simpleHash=new SimpleHash("MD5","123",bytes,1024);
        System.out.println(simpleHash);
    }
}

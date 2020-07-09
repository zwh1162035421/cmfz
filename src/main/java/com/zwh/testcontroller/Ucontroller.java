package com.zwh.testcontroller;


import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.zwh.entity.User;
import com.zwh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("account")
public class Ucontroller {

    @Autowired
    UserService userService;


    @RequestMapping("login")
    public Object userLogin(String username, String password) {
        HashMap<String, Object> map = new HashMap<>();
        User user = null;
        try {
            user = userService.userLogin(username, password);
            return user;
        } catch (Exception e) {
            map.put("code", "-200");
            map.put("errmsg", "密码错误");
            e.printStackTrace();
        }
        return map;
    }

    //查询所有用户
    @RequestMapping("queryAU")
    public Object queryAU(String id) {
        HashMap<String, Object> map = new HashMap<>();
        List<User> users = null;
        try {
            users = userService.queryAU();
            return users;
        } catch (Exception e) {
            map.put("code", "-200");
            map.put("errmsg", "会员列表为空");
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("vCode")
    public String vCode(String phone) {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "XXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXX");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", phone);
        request.putQueryParameter("SignName", "开课吧");
        request.putQueryParameter("TemplateCode", "SMS_178761600");
        String code = getCode();
        System.out.println(code);
        request.putQueryParameter("TemplateParam", "{\"code\":\"" + code + "\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ClientException e) {
            e.printStackTrace();
        }

        return code;
    }

    public static void main(String[] args) {
        /*DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI4FpdDyyvtbkErxXYPam5", "AT6wXqPUOeHEmKSj6Q4AC4BPnzjs2O");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", "13526284974");
        request.putQueryParameter("SignName", "天圆地方");
        request.putQueryParameter("TemplateCode", "SMS_164100021");
        String code=getCode();
        System.out.println(code);
        request.putQueryParameter("TemplateParam", "{\"code\":\""+code+"\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ClientException e) {
            e.printStackTrace();
        }*/
    }

    public static String getCode() {
        int newNum = (int) ((Math.random() * 9 + 1) * 100000);
        return String.valueOf(newNum);
    }

}

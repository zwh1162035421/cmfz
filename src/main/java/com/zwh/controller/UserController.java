package com.zwh.controller;

import com.zwh.entity.User;
import com.zwh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    UserService userService;

    //近期用户注册情况
    @ResponseBody
    @RequestMapping("queryByDate")
    public Map queryByDate() {
        //近三周男用户
        Integer oneworkn = userService.queryByDate("男", 7);
        Integer towworkn = userService.queryByDate("男", 14);
        Integer threeworkn = userService.queryByDate("男", 21);
        //近三周女用户
        Integer oneworkw = userService.queryByDate("女", 7);
        Integer towworkw = userService.queryByDate("女", 14);
        Integer threeworkw = userService.queryByDate("女", 21);
        List<Object> list = new ArrayList<>();
        HashMap<String, Object> map = new HashMap<>();
        int[] a = {oneworkn, towworkn, threeworkn};
        int[] b = {oneworkw, towworkw, threeworkw};
        map.put("datan", a);
        map.put("dataw", b);
        System.out.println(map);
        return map;
    }


    @ResponseBody
    @RequestMapping("queryBypro")
    public List queryBypro() {
        ArrayList<Map> list = new ArrayList<>();
        Map<String, String> map1 = userService.queryBypro("男");
        Map<String, String> map2 = userService.queryBypro("女");
        list.add(map1);
        list.add(map2);
        return list;
    }

    @ResponseBody
    @RequestMapping("register")
    public String register(User user) {
        System.out.println(user);
        userService.insertUser(user);
        return null;
    }
}

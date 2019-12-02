package com.zwh.service;

import com.zwh.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    public Integer queryByDate(String sex, Integer num);

    //查询用户地区分布
    public Map<String, String> queryBypro(String sex);

    //用户注册
    public void insertUser(User user);

    //用户登陆
    public User userLogin(String username, String password);

    //查询所有用户
    public List<User> queryAU();
}

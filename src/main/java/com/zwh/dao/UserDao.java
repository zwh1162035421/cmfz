package com.zwh.dao;

import com.zwh.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserDao {
    //查询最近用户注册数量
    public Integer queryByDate(@Param("sex") String sex, @Param("num") Integer num);

    //查询用户地区分布
    public List<Map<String, String>> queryBypro(String sex);

    //用户注册
    public void insertUser(User user);

    //用户登录
    public User userLogin(@Param("username") String username, @Param("password") String password);

    //查询所有用户
    public List<User> queryAU();
}

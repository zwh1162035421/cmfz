package com.zwh.service;

import com.zwh.dao.UserDao;
import com.zwh.entity.User;
import io.goeasy.GoEasy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class UserServiceImpl implements UserService {


    @Autowired
    UserDao userDao;

    //近期新用户注册情况
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Integer queryByDate(String sex, Integer num) {
        Integer integer = userDao.queryByDate(sex, num);
        return integer;
    }

    //查询用户地区分布
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, String> queryBypro(String sex) {
        Map<String, String> map1 = new HashMap<>();
        List<Map<String, String>> maps = userDao.queryBypro(sex);
        for (Map<String, String> map : maps) {
            String province = map.get("province");
            String num = String.valueOf(map.get("count(id)"));
            map1.put(province, num);
        }
        return map1;
    }

    //用户注册
    @Override
    public void insertUser(User user) {
        String id = UUID.randomUUID().toString();
        user.setId(id);
        user.setUrl("/a/b/b.jpg");
        user.setCreatedate(new Date());
        GoEasy goEasy = null;
        try {
            userDao.insertUser(user);
            goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-85ba961dd6824fb4867d8dda1a70e027");
            goEasy.publish("asd", "注册成功1人");
        } catch (Exception e) {
            e.printStackTrace();
            goEasy.publish("asd", "注册失败");
        }

    }

    //用户登录
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public User userLogin(String username, String password) {
        User user = userDao.userLogin(username, password);
        return user;
    }

    //查询用户列表
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<User> queryAU() {
        List<User> users = userDao.queryAU();
        return users;
    }
}

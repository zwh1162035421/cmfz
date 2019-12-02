package com.zwh.dao;

import com.zwh.entity.Admin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDao {

    //测试查询所有
    public List<Admin> findAllAdmin();

    //根据用户名密码查询管理员
    public Admin findByUserAndPassword(@Param("username") String username);
}

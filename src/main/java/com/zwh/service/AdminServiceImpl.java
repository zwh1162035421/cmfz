package com.zwh.service;

import com.zwh.dao.AdminDao;
import com.zwh.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminDao adminDao;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Admin> findAllAdmin() {
        return adminDao.findAllAdmin();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map findByUserAndPassword(String username, String password, String code, HttpSession session) {

        Map<String, Object> map = new HashMap<>();
        String verifyCode = (String) session.getAttribute("verifyCode");
        code = code.toLowerCase();
        verifyCode = verifyCode.toLowerCase();
        //验证码判断
        if (code.equals(verifyCode)) {
            //验证用户名
            Admin admin = adminDao.findByUserAndPassword(username);
            if (admin != null) {
                //判断密码
                if (password.equals(admin.getPassword())) {
                    session.setAttribute("admin", admin);
                    map.put("admin", admin);
                    map.put("msg", "ok");
                    return map;
                } else {
                    map.put("msg", "密码错误");
                    return map;
                }

            } else {
                map.put("msg", "用户名不存在");
                return map;
            }

        } else {
            map.put("msg", "验证码错误");
            return map;
        }

    }
}

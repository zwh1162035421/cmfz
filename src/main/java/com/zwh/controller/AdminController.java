package com.zwh.controller;

import com.zwh.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    AdminService adminService;

   /* @RequestMapping("findAllAdmin")
    public List<Admin> findAllAdmin(){
       // System.out.println("username = [" + username + "], password = [" + password + "]");
        List<Admin> allAdmin = adminService.findAllAdmin();
        return allAdmin;
    }*/

    @RequestMapping("findByUserAndPassword")
    public Map findByUserAndPassword(String username, String password, String code, HttpSession session) {
        Map map = adminService.findByUserAndPassword(username, password, code, session);
        return map;
    }

}

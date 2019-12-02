package com.zwh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class LoginOut {

    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.invalidate();
        return "redirect:/login/login.jsp";
    }
}

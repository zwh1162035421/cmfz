package com.zwh.service;

import com.zwh.entity.Admin;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface AdminService {
    public List<Admin> findAllAdmin();

    public Map findByUserAndPassword(String username, String password, String code, HttpSession session);
}

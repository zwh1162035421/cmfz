package com.zwh.service;

import com.zwh.entity.Banner;

import java.util.List;

public interface BannerService {
    //加入一个轮播图
    public void addBanner(Banner banner);

    //查询
    public List<Banner> findAllBanner();

    //修改图片路径
    public void updateBannerById(String id, String imgPath);

    //修改
    public void updateBanner(Banner banner);

    //删除一条
    public void deleteBanner(String id);

    //分页查询
    public List<Banner> findAllByPage(Integer page, Integer rows);

    //查询总条数
    public Integer count();

    //批量删除
    public void deleteMath(String[] ids);
}

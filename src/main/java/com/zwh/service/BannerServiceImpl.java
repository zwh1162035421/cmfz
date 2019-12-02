package com.zwh.service;

import com.zwh.dao.BannerDao;
import com.zwh.entity.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {

    @Autowired
    BannerDao bannerDao;

    //添加轮播图

    @Override
    public void addBanner(Banner banner) {

        bannerDao.addBanner(banner);
    }

    //查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Banner> findAllBanner() {
        List<Banner> allBanner = bannerDao.findAllBanner();
        return allBanner;
    }

    //修改图片路径
    @Override
    public void updateBannerById(String id, String imgPath) {
        bannerDao.updateBannerById(id, imgPath);
    }

    //修改
    @Override
    public void updateBanner(Banner banner) {
        bannerDao.updateBanner(banner);
    }

    //删除一条
    @Override
    public void deleteBanner(String id) {
        bannerDao.deleteBanner(id);
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Banner> findAllByPage(Integer page, Integer rows) {
        int start = (page - 1) * rows;
        List<Banner> allByPage = bannerDao.findAllByPage(start, rows);

        return allByPage;
    }

    //查询总条数
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Integer count() {
        return bannerDao.findCount();
    }

    //批量删除
    @Override
    public void deleteMath(String[] ids) {
        bannerDao.deleteMath(ids);
    }
}

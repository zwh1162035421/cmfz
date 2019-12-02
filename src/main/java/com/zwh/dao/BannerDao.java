package com.zwh.dao;

import com.zwh.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BannerDao {
    //添加
    public void addBanner(Banner banner);

    //查询
    public List<Banner> findAllBanner();

    //修改图片路径
    public void updateBannerById(@Param("id") String id, @Param("imgPath") String imgPath);

    //修改
    public void updateBanner(Banner banner);

    //删除一条
    public void deleteBanner(String id);

    //分页查询
    public List<Banner> findAllByPage(@Param("start") int start, @Param("rows") int rows);

    //查询总条数
    public Integer findCount();

    //批量删除
    public void deleteMath(String[] ids);
}

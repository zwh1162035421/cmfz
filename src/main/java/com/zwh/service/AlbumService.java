package com.zwh.service;

import com.zwh.entity.Album;

import java.util.Map;

public interface AlbumService {
    //分页查询
    public Map findAllByPage(Integer page, Integer rows);

    //查询总条数
    public Integer findCount();

    //添加
    public void addAlbum(Album album);

    //修改图片路径
    public void update(String id, String imgPath);

    //修改
    public void updateById(Album album);

    //批量删除
    public void deleteMath(String[] ids);

    //根据id查询
    public Album selectById(String id);
}


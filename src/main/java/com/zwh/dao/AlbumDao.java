package com.zwh.dao;


import com.zwh.entity.Album;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumDao {
    //分页查询
    public List<Album> findAllByPage(@Param("start") Integer start, @Param("rows") Integer rows);

    //查询总条数
    public Integer findCount();

    //添加
    public void addAlbum(Album album);

    //修改图片路径
    public void update(@Param("id") String id, @Param("imgPath") String imgPath);

    //修改
    public void updateById(Album album);

    //批量删除
    public void deleteMath(String[] ids);

    //根据id
    public Album selectById(String id);
}

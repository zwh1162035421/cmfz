package com.zwh.service;

import com.zwh.dao.AlbumDao;
import com.zwh.entity.Album;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    AlbumDao albumDao;

    //分页查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map findAllByPage(Integer page, Integer rows) {

        int start = (page - 1) * rows;
        Map<String, Object> map = new HashMap<>();
        List<Album> allByPage = albumDao.findAllByPage(start, rows);
        Integer count = albumDao.findCount();

        long total = count % rows == 0 ? count / rows : count / rows + 1;
        map.put("rows", allByPage);
        map.put("page", page);
        map.put("records", count);
        map.put("total", total);
        return map;
    }

    //查询总条数
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Integer findCount() {
        Integer count = albumDao.findCount();
        return count;
    }

    //添加
    @Override
    public void addAlbum(Album album) {
        albumDao.addAlbum(album);
    }

    //修改图片路径
    @Override
    public void update(String id, String imgPath) {
        albumDao.update(id, imgPath);
    }

    //修改
    @Override
    public void updateById(Album album) {
        albumDao.updateById(album);
    }

    //批量删除
    @Override
    public void deleteMath(String[] ids) {
        albumDao.deleteMath(ids);
    }

    //根据id查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Album selectById(String id) {
        Album album = albumDao.selectById(id);
        return album;
    }


}

package com.zwh.service;

import com.zwh.dao.ChapterDao;
import com.zwh.entity.Chapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ChapterServiceImpl implements ChapterService {

    @Autowired
    ChapterDao chapterDao;


    //分页查询章节
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map findAllByPage(Integer page, Integer rows, String aid) {
        int start = (page - 1) * rows;
        Map<String, Object> map = new HashMap<>();
        System.out.println(start + "!!!!!!!!!!" + rows + "!!!!!!!!!!!!!" + aid);
        List<Chapter> allByPage = chapterDao.findAllByPage(start, rows, aid);
        Integer count = findCount(aid);

        long total = count % rows == 0 ? count / rows : count / rows + 1;
        map.put("rows", allByPage);
        map.put("page", page);
        map.put("records", count);
        map.put("total", total);
        return map;
    }

    //查询本专辑下章节总数
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Integer findCount(String aid) {
        Integer count = chapterDao.findCount(aid);
        return count;
    }

    //添加
    @Override
    public void addChapter(Chapter chapter) {
        chapterDao.addChapter(chapter);
    }

    //修改
    @Override
    public void update(String id, String size, String timesize, String audio, String pid) {
        chapterDao.update(id, size, timesize, audio, pid);
    }

    //根据id修改
    @Override
    public void updateById(String id, String title) {
        chapterDao.updateById(id, title);
    }

    //批量删除
    @Override
    public void deleteMath(String[] ids) {
        chapterDao.deleteMath(ids);
    }


    //不分页查询章节
    @Override
    public List<Chapter> findAllByAid(String aid) {
        List<Chapter> allByAid = chapterDao.findAllByAid(aid);
        return allByAid;
    }
}

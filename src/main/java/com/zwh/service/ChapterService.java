package com.zwh.service;

import com.zwh.entity.Chapter;

import java.util.List;
import java.util.Map;

public interface ChapterService {
    //分页查询章节
    public Map findAllByPage(Integer page, Integer rows, String aid);

    //查询专辑中章节总数
    public Integer findCount(String aid);

    //添加
    public void addChapter(Chapter chapter);

    //修改
    public void update(String id, String size, String timesize, String audio, String pid);

    //
    public void updateById(String id, String title);

    //批量删除
    public void deleteMath(String[] ids);

    //不分页查询章节
    public List<Chapter> findAllByAid(String aid);

}

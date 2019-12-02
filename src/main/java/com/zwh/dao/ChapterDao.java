package com.zwh.dao;

import com.zwh.entity.Chapter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChapterDao {
    //分页查询所有章节
    public List<Chapter> findAllByPage(@Param("start") Integer start, @Param("rows") Integer rows, @Param("aid") String aid);

    //查询总条数
    public Integer findCount(String aid);

    //添加
    public void addChapter(Chapter chapter);

    //修改
    public void update(@Param("id") String id, @Param("size") String size, @Param("timesize") String timesize, @Param("audio") String audio, @Param("pid") String pid);

    //根据id修改
    public void updateById(@Param("id") String id, @Param("title") String title);

    //批量删除
    public void deleteMath(String[] ids);

    //部分也查询
    public List<Chapter> findAllByAid(String aid);
}


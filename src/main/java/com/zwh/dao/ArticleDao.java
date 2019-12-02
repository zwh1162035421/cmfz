package com.zwh.dao;

import com.zwh.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleDao {
    //分页查询
    public List<Article> findAllByPage(@Param("start") int start, @Param("rows") int rows);

    //查询总条数
    public Integer findCount();

    //添加
    public void addArticle(Article article);

    //修改
    public void updateArticle(Article article);

    //删除
    public void deleteArticle(String[] id);
}

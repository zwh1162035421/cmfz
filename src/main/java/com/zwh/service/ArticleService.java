package com.zwh.service;

import com.zwh.entity.Article;

import java.util.Map;

public interface ArticleService {
    //分页查询
    public Map findAllByPage(int page, int rows);

    //查询总条数
    public Integer findCount();

    //添加
    public void addArticle(Article article);

    //修改
    public void updateArticle(Article article);

    //删除
    public void deleteArticle(String[] id);
}

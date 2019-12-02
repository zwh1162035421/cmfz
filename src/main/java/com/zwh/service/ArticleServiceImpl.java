package com.zwh.service;

import com.zwh.dao.ArticleDao;
import com.zwh.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    ArticleDao articleDao;

    //分页查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map findAllByPage(int page, int rows) {
        Integer count = findCount();
        int start = (page - 1) * rows;
        Map<String, Object> map = new HashMap<>();
        int total = count % rows == 0 ? count / rows : count / rows + 1;
        List<Article> allByPage = articleDao.findAllByPage(start, rows);
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
        Integer count = articleDao.findCount();
        return count;
    }


    //添加
    @Override
    public void addArticle(Article article) {
        String id = UUID.randomUUID().toString();
        Date date = new Date();
        article.setId(id);
        article.setCreatTime(date);
        article.setPubdate(date);
        articleDao.addArticle(article);
    }

    //修改
    @Override
    public void updateArticle(Article article) {
        articleDao.updateArticle(article);
    }

    //删除
    @Override
    public void deleteArticle(String[] id) {
        articleDao.deleteArticle(id);
    }
}

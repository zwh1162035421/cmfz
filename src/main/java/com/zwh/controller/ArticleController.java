package com.zwh.controller;

import com.zwh.entity.Article;
import com.zwh.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("article")
public class ArticleController {

    @Autowired
    ArticleService articleService;

    //分页查询
    @RequestMapping("findAllByPage")
    public Map findAllByPage(Integer page, Integer rows) {
        Map allByPage = articleService.findAllByPage(page, rows);
        return allByPage;
    }

    //添加
    @RequestMapping("add")
    public void add(Article article) {
        articleService.addArticle(article);
    }

    //修改
    @RequestMapping("update")
    public void update(Article article) {
        articleService.updateArticle(article);

    }

    //删除
    @RequestMapping("edit")
    public String edit(String oper, String[] id) {

        if (oper.equals("del")) {
            articleService.deleteArticle(id);
        }
        return id[0];
    }

}

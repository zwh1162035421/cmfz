package com.zwh.controller;

import com.zwh.entity.Chapter;
import com.zwh.service.ChapterService;
import com.zwh.util.MyVideoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("chapter")
public class ChapterController {

    @Autowired
    ChapterService chapterService;


    @RequestMapping("upload")
    public void upload(MultipartFile audio, String aId, String pid, HttpSession session) {
        String realPath = session.getServletContext().getRealPath("/audio/");
        File file = new File(realPath);


        long size1 = audio.getSize() / 1024 / 1024;
        String size = size1 + "MB";

        if (!file.exists()) {
            file.mkdirs();
        }
        String filename = audio.getOriginalFilename();
        String newFileName = new Date().getTime() + "_" + filename;
        File source = new File(file, newFileName);
        String videoTime = null;//时长
        try {
            audio.transferTo(source);
            videoTime = MyVideoUtil.getVideoTime(source);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //修改数据库的路径,文件大小，文件时长,父id

        chapterService.update(aId, size, videoTime, newFileName, pid);
    }

    //添加、删除、修改
    @RequestMapping("edit")
    public String add(String oper, Chapter chapter, String[] id) {
        if (oper.equals("add")) {
            String chapterId = UUID.randomUUID().toString();
            chapter.setId(chapterId);
            //大小(默认)
            chapter.setSize("1");
            //时常（默认）
            chapter.setTimeSize("1");
            //上传时间
            chapter.setCreatetime(new Date());
            //所属专辑id
            chapter.setAid("1");
            chapterService.addChapter(chapter);
            return chapterId;
        } else if (oper.equals("edit")) {
            //修改
            chapterService.updateById(chapter.getId(), chapter.getTitle());

        } else if (oper.equals("del")) {
            //批量删除
            chapterService.deleteMath(id);
        }
        return null;
    }

    //分页查询
    @RequestMapping("findAllByPage")
    public Map findAllByPage(Integer page, Integer rows, String aid) {

        Map allByPage = chapterService.findAllByPage(page, rows, aid);
        return allByPage;
    }
}

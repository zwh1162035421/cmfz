package com.zwh.controller;

import com.zwh.entity.Album;
import com.zwh.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("album")
public class AlbumController {

    @Autowired
    AlbumService albumService;

    @RequestMapping("findAllByPage")
    public Map findAllByPage(Integer page, Integer rows) {
        Map allByPage = albumService.findAllByPage(page, rows);
        return allByPage;
    }

    //添加
    @RequestMapping("edit")
    public String edit(String oper, Album album, String[] id) {

        if (oper.equals("add")) {
            String albumId = UUID.randomUUID().toString();
            //score
            //  creattime   imgPath
            album.setId(albumId);
            album.setScore(10);
            album.setCreattime(new Date());
            albumService.addAlbum(album);
            return albumId;
        } else if (oper.equals("edit")) {
            albumService.updateById(album);
        } else if (oper.equals("del")) {
            albumService.deleteMath(id);
        }
        return null;
    }


    //文上传
    @RequestMapping("upload")
    public void upload(MultipartFile imgPath, String aId, HttpSession session) {
        String realPath = session.getServletContext().getRealPath("/img/");
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }
        String filename = imgPath.getOriginalFilename();
        String newFileName = new Date().getTime() + "_" + filename;

        try {
            imgPath.transferTo(new File(file, newFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        //修改数据库的路径。
        albumService.update(aId, newFileName);
    }

}

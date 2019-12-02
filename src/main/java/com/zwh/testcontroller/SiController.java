package com.zwh.testcontroller;

import com.zwh.entity.Album;
import com.zwh.entity.Chapter;
import com.zwh.service.AlbumService;
import com.zwh.service.ChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("detail")
public class SiController {

    @Autowired
    AlbumService albumService;
    @Autowired
    ChapterService chapterService;

    @RequestMapping("si")
    public Map article(String id, String uudc) {
        HashMap<Object, Object> map = new HashMap<>();

        try {
            map.put("code", 200);
            map.put("link", "http://xxx/1000.html");
            map.put("id", id);
            map.put("ext", "");
        } catch (Exception e) {
            map.put("code", 500);
            map.put("msg", "参数错误");
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("wen")
    public Map wen(String id, String uid) {
        Map map = new HashMap<String, Object>();
        //专辑
        Album album = albumService.selectById(id);
        //专辑下章节
        List<Chapter> allByAid = chapterService.findAllByAid(id);
        try {
            map.put("code", 200);
            map.put("introduction", album);
            map.put("list", allByAid);
        } catch (Exception e) {
            map.put("code", 200);
            map.put("msg", "参数错误");
            e.printStackTrace();
        }

        return map;
    }
}

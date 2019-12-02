package com.zwh.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("kindEditor")
public class KindeditorController {


    //使用富文本编辑器上传图片返回一个map
    //其中封装的是{"error":0,"url":"\/ke4\/attached\/W020091124524510014093.jpg"}
    //格式的数据
    @RequestMapping("upload")
    public Map<String, Object> upload(MultipartFile img, HttpSession session, HttpServletRequest request) throws IOException {
        Map<String, Object> map = new HashMap<>();
        String realPath = session.getServletContext().getRealPath("/img/");
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }
        String filename = img.getOriginalFilename();
        String newName = new Date().getTime() + "_" + filename;
        img.transferTo(new File(realPath, newName));
        //封装第一个k v
        map.put("error", 0);
        //获取协议http
        String scheme = request.getScheme();
        //获取服务器计算机名+ip    DESKTOP-3SL2VKH/10.103.59.126
        InetAddress localHost = Inet4Address.getLocalHost();
        //获取ip  10.103.59.126
        String address = localHost.getHostAddress();
        //获取项目访问端口号8989
        int port = request.getServerPort();
        //获取项目访问名 /cmfz
        String path = request.getContextPath();

        String url = scheme + "://" + address + ":" + port + path + "/img/" + newName;
        // http ://127.0.0.1:8989/cmfz/img/
        map.put("url", url);
        return map;
    }


    //在图片空间展示图片
    //需要封装成map,格式如下：map{
    //                         list[
    //                             map{},
    //                             map{},
    //                             map{},
    //                         ]
    //                      }
    /*
{
	"moveup_dir_path": "",
	"current_dir_path": "",
	"current_url": "\/ke4\/php\/..\/attached\/",
	"total_count": 5,
	"file_list": [
	{
		"is_dir": false,
		"has_file": false,
		"filesize": 208736,
		"dir_path": "",
		"is_photo": true,
		"filetype": "jpg",
		"filename": "1241601537255682809.jpg",
		"datetime": "2018-06-06 00:36:39"
	}]
}
        * */
    @RequestMapping("getAllImg")
    public Map<String, Object> getAll(HttpServletRequest request) throws UnknownHostException {
        Map<String, Object> map = new HashMap<>();
        ArrayList<Map<String, Object>> list = new ArrayList<>();
        String realPath = request.getSession().getServletContext().getRealPath("/img/");
        File file = new File(realPath);
        //获取该文件下的所有文件名
        String[] names = file.list();
        for (String name : names) {
            //封装list里面的小map
            HashMap<String, Object> map1 = new HashMap<>();
            map1.put("is_dir", false);
            map1.put("has_file", false);
            File file1 = new File(realPath, name);
            long length = file1.length();
            map1.put("filesize", length);
            map1.put("is_photo", true);
            String s = name.substring(name.lastIndexOf(".") + 1);
            map1.put("filetype", s);
            map1.put("filename", name);
            boolean b = name.contains("_");
            if (b) {
                String s1 = name.split("_")[0];
                Long aLong = Long.valueOf(s1);
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String s2 = format.format(aLong);
                map1.put("datetime", s2);
            }
            if (!b) {
                map1.put("datetime", new Date());
            }
            map1.put("datetime", name);
            map1.put("dir_path", "");
            list.add(map1);
        }
        String scheme = request.getScheme();
        InetAddress localHost = Inet4Address.getLocalHost();
        String address = localHost.getHostAddress();
        int port = request.getServerPort();
        String path = request.getContextPath();
        String url = scheme + "://" + address + ":" + port + path + "/img/";
        //System.out.println(url+"~~~~~~~~~~~~~~~~~~~~~~~~~");

        map.put("moveup_dir_path", "");
        map.put("current_dir_path", "");

        map.put("current_url", url);
        map.put("total_count", names.length);
        map.put("file_list", list);
        return map;
    }

}

package com.zwh.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.zwh.entity.Banner;
import com.zwh.service.BannerService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

@RestController
@RequestMapping("banner")
public class BannerController {

    @Autowired
    BannerService bannerService;


    /*//添加轮播图
    @RequestMapping("addBanner")
    public String addBanner(Banner banner){

        return null;
    }*/


    //查询轮播图
    @RequestMapping("findAllBanner")
    public List<Banner> findAllBanner() {
        List<Banner> allBanner = bannerService.findAllBanner();
        return allBanner;
    }

    @RequestMapping("edit")
    public String add(String oper, Banner banner, String[] id) {
        System.out.println("oper====" + oper);
        if (oper.equals("add")) {
            String bannerId = UUID.randomUUID().toString();
            banner.setCreatTime(new Date());
            banner.setId(bannerId);
            bannerService.addBanner(banner);
            System.out.println(banner);
            return bannerId;
        } else if (oper.equals("edit")) {
            bannerService.updateBanner(banner);
            return "edit";
        } else if (oper.equals("del")) {
            bannerService.deleteMath(id);
            System.out.println(banner);
        }
        return null;
    }

    @RequestMapping("upload")
    public void upload(MultipartFile imgPath, String bId, HttpSession session) {
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
        bannerService.updateBannerById(bId, newFileName);
    }

    //分页查询
    @RequestMapping("findAllByPage")
    public Map findAllByPage(Integer page, Integer rows) {
        List<Banner> allByPage = bannerService.findAllByPage(page, rows);
        Map<Object, Object> map = new HashMap<>();
        Integer count = bannerService.count();
        long total = count % rows == 0 ? count / rows : count / rows + 1;
        map.put("rows", allByPage);
        map.put("page", page);
        map.put("records", count);
        map.put("total", total);
        return map;
    }

    //导出表格downpoi
    @RequestMapping("downpoi")
    public List<Banner> downPoi() {
        List<Banner> allBanner = bannerService.findAllBanner();
        List<Banner> banners = new ArrayList<>();
        for (Banner banner : allBanner) {
            String imgPath = banner.getImgPath();
            String newPath = "E:\\IntelliJIDEA\\maven\\cmfz\\src\\main\\webapp\\img\\" + imgPath;
            banner.setImgPath(newPath);
            banners.add(banner);
        }

        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("轮播图表", "轮播图"),
                Banner.class, banners);
        try {
            workbook.write(new FileOutputStream(new File("E:\\IntelliJIDEA\\maven\\cmfz\\src\\main\\webapp\\exportpoi\\轮播图.xls")));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return allBanner;
    }


    //文件下载
    @RequestMapping("down")
    public void down(HttpSession session, HttpServletResponse response) throws UnsupportedEncodingException {
        String realPath = session.getServletContext().getRealPath("/exportpoi");
        File file = new File(realPath, "轮播图.xls");
        String encode = URLEncoder.encode("轮播图.xls", "UTF-8");
        response.setHeader("content-disposition", "attachment;fileName=" + encode);
        ServletOutputStream outputStream = null;
        try {
            outputStream = response.getOutputStream();
            FileUtils.copyFile(file, outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

}

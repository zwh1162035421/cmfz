package com.zwh.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class Banner {
    @Excel(name = "轮播图主键")
    private String id;
    @Excel(name = "标题")
    private String title;
    @Excel(name = "状态", replace = {"展示_y", "不展示_n"})
    private String status;
    @Excel(name = "描述")
    private String des;
    @Excel(name = "图片", type = 2)
    private String imgPath;
    @Excel(name = "创建时间", format = "yyyy-MM-dd")
    private Date creatTime;
}

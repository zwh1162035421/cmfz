package com.zwh.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class Article {
    private String id;
    private String title;
    private String status;
    private String author;
    private String content;
    private Date creatTime;
    private Date pubdate;
    private String guruid;
}

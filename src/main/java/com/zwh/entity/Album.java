package com.zwh.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class Album implements Serializable {
    private String id;
    private String title;
    private double score;
    private String author;
    private String teller;
    private int chapterNum;
    private String albumAbout;
    private String status;
    private Date issuedate;
    private Date creattime;
    private String imgPath;
    //private List<Chapter> chapter;
}

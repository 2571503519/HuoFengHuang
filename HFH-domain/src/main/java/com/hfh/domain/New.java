package com.hfh.domain;

import java.util.Date;

/*
CREATE TABLE `news` (
  `new_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `new_title` varchar(100) NOT NULL,
  `new_content` text NOT NULL,
  `author` varchar(50) NOT NULL,
  `create_time` date NOT NULL,
  `update_time` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '文章的状态, 0 未发布，1 已发布，-1删除',
  PRIMARY KEY (`new_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
 */
/**
 * 新闻实体类
 * @author 家乐
 *
 */
public class New {
	
	private Long new_id;
	private String new_title;
	private String new_desc;
	private String new_content;
	private String author;
	private String source;
	private Date create_time;
	private Date update_time;
	private Integer status = 0; // 新闻状态, 0 未发布，1已发布，-1已删除
	
	public Long getNew_id() {
		return new_id;
	}
	public void setNew_id(Long new_id) {
		this.new_id = new_id;
	}
	public String getNew_title() {
		return new_title;
	}
	public void setNew_title(String new_title) {
		this.new_title = new_title;
	}
	public String getNew_desc() {
		return new_desc;
	}
	public void setNew_desc(String new_desc) {
		this.new_desc = new_desc;
	}
	public String getNew_content() {
		return new_content;
	}
	public void setNew_content(String new_content) {
		this.new_content = new_content;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "New [new_id=" + new_id + ", new_title=" + new_title + ", new_content=" + new_content + ", author="
				+ author + ", create_time=" + create_time + ", update_time=" + update_time + ", status=" + status + "]";
	}
}

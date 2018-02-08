package com.hfh.domain;

import java.util.Date;

/*
CREATE TABLE `common_sense` (
  `sense_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sense_title` varchar(100) NOT NULL,
  `sense_content` text NOT NULL,
  `create_time` date DEFAULT NULL,
  `update_time` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 */
/**
 * 常识实体类
 * @author 家乐
 *
 */
public class CommonSense {
	
	private Long sense_id;
	private String sense_title;
	private String sense_content;
	private Date create_time;
	private Date update_time;
	private Integer status = 0; // 新闻状态, 0 未发布，1已发布，-1已删除
	
	public Long getSense_id() {
		return sense_id;
	}
	public void setSense_id(Long sense_id) {
		this.sense_id = sense_id;
	}
	public String getSense_title() {
		return sense_title;
	}
	public void setSense_title(String sense_title) {
		this.sense_title = sense_title;
	}
	public String getSense_content() {
		return sense_content;
	}
	public void setSense_content(String sense_content) {
		this.sense_content = sense_content;
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
	
}

package com.hfh.domain;

import java.util.Date;

/*
CREATE TABLE `law` (
  `law_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `law_title` varchar(100) NOT NULL,
  `law_content` text NOT NULL,
  `create_time` date DEFAULT NULL,
  `update_time` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`law_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;
 */
/**
 * 消防法规实体类
 * @author 家乐
 *
 */
public class Law {
	
	private Long law_id;
	private String law_title;
	private String law_content;
	private Date create_time;
	private Date update_time;
	private Integer status = 0; // 新闻状态, 0 未发布，1已发布，-1已删除
	

	public Long getLaw_id() {
		return law_id;
	}
	public void setLaw_id(Long law_id) {
		this.law_id = law_id;
	}
	public String getLaw_title() {
		return law_title;
	}
	public void setLaw_title(String law_title) {
		this.law_title = law_title;
	}
	public String getLaw_content() {
		return law_content;
	}
	public void setLaw_content(String law_content) {
		this.law_content = law_content;
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

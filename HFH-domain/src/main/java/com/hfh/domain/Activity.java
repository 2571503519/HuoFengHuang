package com.hfh.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/*
CREATE TABLE `activity` (
  `act_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `act_title` varchar(100) NOT NULL COMMENT '活动标题',
  `act_content` text NOT NULL COMMENT '活动内容',
  `act_addr` varchar(100) NOT NULL COMMENT '活动地点',
  `sponsor` varchar(100) DEFAULT NULL COMMENT '活动主办方',
  `live_url` varchar(255) DEFAULT NULL,
  `start_time` date NOT NULL COMMENT '活动开始时间',
  `end_time` date NOT NULL COMMENT '活动结束时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`act_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;
 */
public class Activity {
	
	private Long act_id;
	private String act_title;
	private String act_content;
	private String act_addr;
	private String sponsor;
	private String live_url; // 活动直播的地址
	private Date start_time;
	private Date end_time;
	private Date create_time;
	private Date update_time;
	private Integer status = 0;
	
	private Set<ActivityVolunteer> actVols = new HashSet<ActivityVolunteer>();
	
	
	public Set<ActivityVolunteer> getActVols() {
		return actVols;
	}
	public void setActVols(Set<ActivityVolunteer> actVols) {
		this.actVols = actVols;
	}
	public Long getAct_id() {
		return act_id;
	}
	public void setAct_id(Long act_id) {
		this.act_id = act_id;
	}
	public String getAct_title() {
		return act_title;
	}
	public void setAct_title(String act_title) {
		this.act_title = act_title;
	}
	public String getAct_content() {
		return act_content;
	}
	public void setAct_content(String act_content) {
		this.act_content = act_content;
	}
	public String getAct_addr() {
		return act_addr;
	}
	public void setAct_addr(String act_addr) {
		this.act_addr = act_addr;
	}
	public String getSponsor() {
		return sponsor;
	}
	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public String getLive_url() {
		return live_url;
	}
	public void setLive_url(String live_url) {
		this.live_url = live_url;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
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



















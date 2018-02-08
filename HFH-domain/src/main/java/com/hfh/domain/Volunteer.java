package com.hfh.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/*
CREATE TABLE `volunteers` (
  `vol_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vol_name` varchar(40) DEFAULT NULL COMMENT '志愿者真实姓名',
  `vol_IDCard` char(18) DEFAULT NULL COMMENT '志愿者身份证号',
  `live_url` varchar(255) DEFAULT NULL COMMENT '志愿者直播链接',
  `province` varchar(20) DEFAULT NULL COMMENT '省/直辖市/自治区',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `county` varchar(20) DEFAULT NULL COMMENT '县/区',
  `town` varchar(20) DEFAULT NULL COMMENT '镇/街道',
  `addr_detail` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `reg_time` datetime DEFAULT NULL COMMENT '成为志愿者的日期',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '志愿者信息状态，0 未激活，1 已激活，-1 已删除',
  PRIMARY KEY (`vol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=utf8;
 */
public class Volunteer {
	
	private Long vol_id;
	private String vol_name;
	private String vol_IDCard;
	private String live_url;
	private String province;
	private String city;
	private String county;
	private String town;
	private String addr_detail;
	private Date reg_time;
	private Integer status = 0;// 志愿者身份状态，0 未激活，1已激活，-1已删除
	
	private Set<ActivityVolunteer> actVols = new HashSet<ActivityVolunteer>();
	
	
	public Set<ActivityVolunteer> getActVols() {
		return actVols;
	}
	public void setActVols(Set<ActivityVolunteer> actVols) {
		this.actVols = actVols;
	}

	public String getAddress() {
		return String.join("-", this.province, this.city, this.county, this.town);
	}
	
	public Long getVol_id() {
		return vol_id;
	}
	public void setVol_id(Long vol_id) {
		this.vol_id = vol_id;
	}
	public String getVol_name() {
		return vol_name;
	}

	public void setVol_name(String vol_name) {
		this.vol_name = vol_name;
	}

	public String getVol_IDCard() {
		return vol_IDCard;
	}
	public void setVol_IDCard(String vol_IDCard) {
		this.vol_IDCard = vol_IDCard;
	}
	public String getLive_url() {
		return live_url;
	}
	public void setLive_url(String live_url) {
		this.live_url = live_url;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public String getAddr_detail() {
		return addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}
	public Date getReg_time() {
		return reg_time;
	}
	public void setReg_time(Date reg_time) {
		this.reg_time = reg_time;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	
}

package com.hfh.domain;

/*
CREATE TABLE `questions` (
  `quest_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quest_content` text NOT NULL COMMENT '题目的内容',
  `quest_result` varchar(255) NOT NULL COMMENT '题目的答案',
  `quest_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `quest_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否被选作考题',
  PRIMARY KEY (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
*/

public class Question {
	private Long quest_id;
	private String quest_content;
	private String quest_result;
	private Integer quest_type;
	private Integer quest_status = 1;
	public Long getQuest_id() {
		return quest_id;
	}
	public void setQuest_id(Long quest_id) {
		this.quest_id = quest_id;
	}
	public String getQuest_content() {
		return quest_content;
	}
	public void setQuest_content(String quest_content) {
		this.quest_content = quest_content;
	}
	public String getQuest_result() {
		return quest_result;
	}
	public void setQuest_result(String quest_result) {
		this.quest_result = quest_result;
	}
	public Integer getQuest_type() {
		return quest_type;
	}
	public void setQuest_type(Integer quest_type) {
		this.quest_type = quest_type;
	}
	public Integer getQuest_status() {
		return quest_status;
	}
	public void setQuest_status(Integer quest_status) {
		this.quest_status = quest_status;
	}
	
	
}

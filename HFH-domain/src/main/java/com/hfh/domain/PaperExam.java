package com.hfh.domain;

import java.util.HashSet;
import java.util.Set;

/*
CREATE TABLE `papers_exam` (
  `paper_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `paper_name` varchar(60) NOT NULL,
  `selected` tinyint(1) unsigned DEFAULT '1' COMMENT '是否被选作为考试用卷',
  PRIMARY KEY (`paper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
 */

public class PaperExam {
	
	private Long paper_id;
	private String paper_name;
	private Integer selected;
	// 存储此份试卷中所有的考题对象
	private Set<ExamQuestion> exam_questions = new HashSet<ExamQuestion>();
	public Long getPaper_id() {
		return paper_id;
	}
	public void setPaper_id(Long paper_id) {
		this.paper_id = paper_id;
	}
	public String getPaper_name() {
		return paper_name;
	}
	public void setPaper_name(String paper_name) {
		this.paper_name = paper_name;
	}
	public Integer getSelected() {
		return selected;
	}
	public void setSelected(Integer selected) {
		this.selected = selected;
	}
	public Set<ExamQuestion> getExam_questions() {
		return exam_questions;
	}
	public void setExam_questions(Set<ExamQuestion> exam_questions) {
		this.exam_questions = exam_questions;
	}
	@Override
	public String toString() {
		return "PaperExam [paper_id=" + paper_id + ", paper_name=" + paper_name + ", selected=" + selected
				+ ", exam_questions=" + exam_questions + "]";
	} 
	
}

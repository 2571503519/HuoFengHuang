package com.hfh.domain;

/*
CREATE TABLE `questions_exam` (
  `exam_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `exam_weights` int(11) DEFAULT NULL,
  `exam_sequence` int(11) DEFAULT NULL,
  `quest_id` int(11) unsigned DEFAULT NULL,
  `paper_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  UNIQUE KEY `UK_bnvb5q12ur63fn8345ia6yssb` (`quest_id`),
  KEY `FKc2mcsthcw19l6rxq3tbkaio2q` (`paper_id`),
  CONSTRAINT `FKc2mcsthcw19l6rxq3tbkaio2q` FOREIGN KEY (`paper_id`) REFERENCES `papers_exam` (`paper_id`),
  CONSTRAINT `FKtfstwviiqbr5cw1hdej8yso6n` FOREIGN KEY (`quest_id`) REFERENCES `questions` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;
 */
public class QuestionExam {
	
	private Long exam_id;
	private Integer exam_weights;
	private Integer exam_sequence;
	private Long quest_id;
	private Long paper_id;
	
	public Long getExam_id() {
		return exam_id;
	}
	public void setExam_id(Long exam_id) {
		this.exam_id = exam_id;
	}
	public Integer getExam_weights() {
		return exam_weights;
	}
	public void setExam_weights(Integer exam_weights) {
		this.exam_weights = exam_weights;
	}
	public Integer getExam_sequence() {
		return exam_sequence;
	}
	public void setExam_sequence(Integer exam_sequence) {
		this.exam_sequence = exam_sequence;
	}
	public Long getQuest_id() {
		return quest_id;
	}
	public void setQuest_id(Long quest_id) {
		this.quest_id = quest_id;
	}
	public Long getPaper_id() {
		return paper_id;
	}
	public void setPaper_id(Long paper_id) {
		this.paper_id = paper_id;
	}
	
}

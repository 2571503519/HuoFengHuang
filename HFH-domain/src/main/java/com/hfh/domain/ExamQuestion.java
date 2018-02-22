package com.hfh.domain;
/*
CREATE TABLE `exam_questions` (
  `exam_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) unsigned NOT NULL,
  `paper_id` int(11) unsigned NOT NULL,
  `exam_weights` tinyint(3) unsigned DEFAULT '5' COMMENT '分值',
  `exam_sequence` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `fk_paper_id` (`paper_id`),
  CONSTRAINT `fk_paper_id` FOREIGN KEY (`paper_id`) REFERENCES `papers_exam` (`paper_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='考卷中的考题表';
 */
public class ExamQuestion {
	
	private Long exam_id;
	private Integer exam_weights = 5;
	private Integer exam_sequence;
	private Question question;
	// 使用外键与papers_exam表中的paper_id关联
	private PaperExam paper_exam;
	public Long getExam_id() {
		return exam_id;
	}
	public void setExam_id(Long exam_id) {
		this.exam_id = exam_id;
	}
	
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
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
	public PaperExam getPaper_exam() {
		return paper_exam;
	}
	public void setPaper_exam(PaperExam paper_exam) {
		this.paper_exam = paper_exam;
	}
	
}

package com.hfh.domain;

/*
CREATE TABLE `cand_answers` (
  `answer_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `answer_result` varchar(255) DEFAULT NULL,
  `quest_id` int(11) unsigned NOT NULL,
  `cand_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `fk_cand_id` (`cand_id`),
  CONSTRAINT `fk_cand_id` FOREIGN KEY (`cand_id`) REFERENCES `candidates` (`cand_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
 */

public class CandAnswer {
	
	private Long answer_id;
	private String answer_result;
	private ExamQuestion examQuestion;
	private Candidate candidate;
	private Integer correct = -1;
	
	public Long getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(Long answer_id) {
		this.answer_id = answer_id;
	}
	public ExamQuestion getExamQuestion() {
		return examQuestion;
	}
	public void setExamQuestion(ExamQuestion examQuestion) {
		this.examQuestion = examQuestion;
	}
	public String getAnswer_result() {
		return answer_result;
	}
	public void setAnswer_result(String answer_result) {
		this.answer_result = answer_result;
	}
	public Candidate getCandidate() {
		return candidate;
	}
	public void setCandidate(Candidate candidate) {
		this.candidate = candidate;
	}
	public Integer getCorrect() {
		return correct;
	}
	public void setCorrect(Integer correct) {
		this.correct = correct;
	}
	
	
}

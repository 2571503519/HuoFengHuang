package com.hfh.utils;

public class CandAnswerBean {

	private Long answer_id;
	private String answer_result;
	private Integer correct;
	
	private Integer exam_weights;
	
	private String quest_content;
	private String quest_result;
	private Integer quest_type;
	public Long getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(Long answer_id) {
		this.answer_id = answer_id;
	}
	public String getAnswer_result() {
		return answer_result;
	}
	public void setAnswer_result(String answer_result) {
		this.answer_result = answer_result;
	}
	public Integer getCorrect() {
		return correct;
	}
	public void setCorrect(Integer correct) {
		this.correct = correct;
	}
	public Integer getExam_weights() {
		return exam_weights;
	}
	public void setExam_weights(Integer exam_weights) {
		this.exam_weights = exam_weights;
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
	
	
}

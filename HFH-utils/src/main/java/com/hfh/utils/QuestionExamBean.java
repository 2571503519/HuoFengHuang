package com.hfh.utils;

public class QuestionExamBean implements Comparable<QuestionExamBean> {
	
	private long exam_id;
	private int exam_weights;
	private int exam_sequence;
	private int quest_type;
	private String quest_content;
	private String quest_result;
	
	public long getExam_id() {
		return exam_id;
	}
	public void setExam_id(long exam_id) {
		this.exam_id = exam_id;
	}
	public int getExam_weights() {
		return exam_weights;
	}
	public void setExam_weights(int exam_weights) {
		this.exam_weights = exam_weights;
	}
	public int getExam_sequence() {
		return exam_sequence;
	}
	public void setExam_sequence(int exam_sequence) {
		this.exam_sequence = exam_sequence;
	}
	public int getQuest_type() {
		return quest_type;
	}
	public void setQuest_type(int quest_type) {
		this.quest_type = quest_type;
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
	@Override
	public int compareTo(QuestionExamBean o) {
		return this.exam_sequence - o.getExam_sequence();
	}
	
}

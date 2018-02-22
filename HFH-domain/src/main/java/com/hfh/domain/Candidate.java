package com.hfh.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/*
CREATE TABLE `candidates` (
  `cand_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cand_name` varchar(50) NOT NULL,
  `cand_username` varchar(50) NOT NULL,
  `cand_date` datetime NOT NULL,
  `cand_grade` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`cand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8;
 */
public class Candidate {
	
	private Long cand_id;
	private String cand_name;
	private String cand_username;
	private Date cand_date;
	private Integer cand_grade;
	
	private Set<CandAnswer> candAnswers = new HashSet<CandAnswer>();
	
	public Set<CandAnswer> getCandAnswers() {
		return candAnswers;
	}
	public void setCandAnswers(Set<CandAnswer> candAnswers) {
		this.candAnswers = candAnswers;
	}
	
	public Integer getCand_grade() {
		return cand_grade;
	}
	public void setCand_grade(Integer cand_grade) {
		this.cand_grade = cand_grade;
	}
	public Long getCand_id() {
		return cand_id;
	}
	public void setCand_id(Long cand_id) {
		this.cand_id = cand_id;
	}
	public String getCand_name() {
		return cand_name;
	}
	public void setCand_name(String cand_name) {
		this.cand_name = cand_name;
	}
	public String getCand_username() {
		return cand_username;
	}
	public void setCand_username(String cand_username) {
		this.cand_username = cand_username;
	}
	public Date getCand_date() {
		return cand_date;
	}
	public void setCand_date(Date cand_date) {
		this.cand_date = cand_date;
	}
	
}

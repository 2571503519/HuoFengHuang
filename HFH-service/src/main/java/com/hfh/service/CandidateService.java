package com.hfh.service;

import java.util.List;

import com.hfh.domain.CandAnswer;
import com.hfh.domain.Candidate;
import com.hfh.domain.Question;
import com.hfh.utils.PageBean;

public interface CandidateService {

	void pageQuery(PageBean pageBean);

	void update(Candidate model);

	Candidate findById(Long cand_id);

	void save(Candidate model);

	void deleteCandidates(String ids);

	List<CandAnswer> findCandAnswerByCandId(Long cand_id);

}

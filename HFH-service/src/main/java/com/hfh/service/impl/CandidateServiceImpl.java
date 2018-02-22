package com.hfh.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.CandAnswerDao;
import com.hfh.dao.CandidateDao;
import com.hfh.domain.CandAnswer;
import com.hfh.domain.Candidate;
import com.hfh.domain.Question;
import com.hfh.service.CandidateService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class CandidateServiceImpl implements CandidateService {
	
	@Autowired
	private CandidateDao candidateDao;
	
	@Autowired
	private CandAnswerDao candAnswerDao;
	
	
	@Override
	public void pageQuery(PageBean pageBean) {
		candidateDao.pageQuery(pageBean);
	}

	@Override
	public void deleteCandidates(String ids) {
		if (StringUtils.isNotBlank(ids)) {
			String[] newIds = ids.split(",");
			for (String newId : newIds) {
				candidateDao.executeUpdate("candidate.delete", Long.parseLong(newId));
			}
		}
	}
	
	@Override
	public void save(Candidate model) {
		candidateDao.save(model);
	}

	@Override
	public Candidate findById(Long cand_id) {
		return candidateDao.findById(cand_id);
	}

	@Override
	public void update(Candidate model) {
		candidateDao.update(model);
	}

	@Override
	public List<CandAnswer> findCandAnswerByCandId(Long cand_id) {
		return candAnswerDao.findByCandId(cand_id);
	}
	
	
}

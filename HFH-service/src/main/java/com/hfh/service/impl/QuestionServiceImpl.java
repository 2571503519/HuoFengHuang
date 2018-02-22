package com.hfh.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.QuestionDao;
import com.hfh.domain.Law;
import com.hfh.domain.Question;
import com.hfh.service.QuestionService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private QuestionDao questionDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		questionDao.pageQuery(pageBean);
	}

	@Override
	public void publishQuestions(String ids) {
		changeQuestionsStatus(ids, "question.publish");
	}

	@Override
	public void revokeQuestions(String ids) {
		changeQuestionsStatus(ids, "question.revoke");
	}

	@Override
	public void deleteQuestions(String ids) {
		changeQuestionsStatus(ids, "question.delete");
	}
	
	private void changeQuestionsStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] newIds = ids.split(",");
			for (String newId : newIds) {
				questionDao.executeUpdate(queryName, Long.parseLong(newId));
			}
		}
	}
	
	@Override
	public void save(Question model) {
		questionDao.save(model);
	}

	@Override
	public Question findById(Long quest_id) {
		return questionDao.findById(quest_id);
	}

	@Override
	public void update(Question model) {
		questionDao.update(model);
	}
	
}

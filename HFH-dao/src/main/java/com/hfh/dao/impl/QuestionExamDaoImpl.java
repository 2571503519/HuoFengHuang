package com.hfh.dao.impl;


import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hfh.dao.QuestionExamDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.QuestionExam;

@Repository
public class QuestionExamDaoImpl extends BaseDaoImpl<QuestionExam> implements QuestionExamDao {

	@Override
	public void saveQuestionExamBatch(List<QuestionExam> questionExamList) {
		for (QuestionExam questionExam : questionExamList) {
			this.save(questionExam);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionExam> findByPaperId(Long paper_id) {
		DetachedCriteria criteria = DetachedCriteria.forClass(QuestionExam.class);
		criteria.add(Restrictions.eq("paper_id", paper_id));
		return (List<QuestionExam>) this.getHibernateTemplate().findByCriteria(criteria);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionExam> findAllById(Long[] ids) {
		DetachedCriteria criteria = DetachedCriteria.forClass(QuestionExam.class);
		criteria.add(Restrictions.in("exam_id", ids));
		return (List<QuestionExam>) this.getHibernateTemplate().findByCriteria(criteria);
	}

	@Override
	public void saveOrUpDateBatch(List<QuestionExam> questionExamList) {
		for (QuestionExam questionExam : questionExamList) {
			this.getHibernateTemplate().saveOrUpdate(questionExam);
		}
	}

}

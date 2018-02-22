package com.hfh.dao.impl;


import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hfh.dao.QuestionDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.Question;

@Repository
public class QuestionDaoImpl extends BaseDaoImpl<Question> implements QuestionDao {

	@Override
	public List<Long> findAllQuestionsIdByType(Integer type) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Question.class);
		criteria.setProjection(Projections.property("quest_id"));
		criteria.add(Restrictions.eq("quest_status", 1));
		criteria.add(Restrictions.eq("quest_type", type));
		return (List<Long>) this.getHibernateTemplate().findByCriteria(criteria);
	}

	@Override
	public List<Long> findAllQuestionsIdByType(Integer type, Long[] exculedIds) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Question.class);
		criteria.setProjection(Projections.property("quest_id"));
		criteria.add(Restrictions.eq("quest_status", 1));
		criteria.add(Restrictions.eq("quest_type", type));
		criteria.add(Restrictions.not(Restrictions.in("quest_id", exculedIds)));
		return (List<Long>) this.getHibernateTemplate().findByCriteria(criteria);
	}

	@Override
	public List<Integer> findQuestionsTypeByIds(Long[] questionIds) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Question.class);
		criteria.setProjection(Projections.property("quest_type"));
		criteria.add(Restrictions.in("quest_id", questionIds));
		return (List<Integer>) this.getHibernateTemplate().findByCriteria(criteria);
	}

	

	
}

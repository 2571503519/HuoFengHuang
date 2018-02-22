package com.hfh.dao.impl;


import java.util.List;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;

import com.hfh.dao.CandAnswerDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.CandAnswer;

@Repository
public class CandAnswerDaoImpl extends BaseDaoImpl<CandAnswer> implements CandAnswerDao {

	@Override
	public List<CandAnswer> findByCandId(Long cand_id) {
		String hql = "FROM CandAnswer WHERE cand_id = ?";
		List<CandAnswer> list = (List<CandAnswer>) this.getHibernateTemplate().find(hql, cand_id);
		
		return list;
	}

}

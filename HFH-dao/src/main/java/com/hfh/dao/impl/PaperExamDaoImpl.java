package com.hfh.dao.impl;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

import com.hfh.dao.PaperExamDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.PaperExam;

@Repository
public class PaperExamDaoImpl extends BaseDaoImpl<PaperExam> implements PaperExamDao {

	@Override
	public Serializable saveAndReturnId(PaperExam model) {
		return this.getHibernateTemplate().save(model);
	}

	 
	
	
}

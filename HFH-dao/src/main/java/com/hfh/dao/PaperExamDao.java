package com.hfh.dao;

import java.io.Serializable;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.PaperExam;

public interface PaperExamDao extends BaseDao<PaperExam> {
	
	Serializable saveAndReturnId(PaperExam model);
	
	
}

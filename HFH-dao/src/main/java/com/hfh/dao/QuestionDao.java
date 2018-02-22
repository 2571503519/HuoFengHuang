package com.hfh.dao;

import java.util.List;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.Question;

public interface QuestionDao extends BaseDao<Question> {

	List<Long> findAllQuestionsIdByType(Integer type);
	
	List<Long> findAllQuestionsIdByType(Integer type, Long[] exculedIds);

	List<Integer> findQuestionsTypeByIds(Long[] questionIds);

}

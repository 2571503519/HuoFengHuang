package com.hfh.dao;

import java.util.List;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.CandAnswer;

public interface CandAnswerDao extends BaseDao<CandAnswer> {

	List<CandAnswer> findByCandId(Long cand_id);

}

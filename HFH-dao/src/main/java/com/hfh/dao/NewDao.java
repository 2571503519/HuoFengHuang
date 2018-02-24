package com.hfh.dao;

import java.util.List;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.New;

public interface NewDao extends BaseDao<New>{

	List<New> findOrdeByCreateTime(int i);

}

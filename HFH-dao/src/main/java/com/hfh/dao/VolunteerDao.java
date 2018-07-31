package com.hfh.dao;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.Volunteer;

public interface VolunteerDao extends BaseDao<Volunteer>{

	Long saveAndReturnId(Volunteer model);

}

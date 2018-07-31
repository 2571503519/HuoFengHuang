package com.hfh.dao.impl;


import java.io.Serializable;

import org.springframework.stereotype.Repository;

import com.hfh.dao.VolunteerDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.Volunteer;

@Repository
public class VolunteerDaoImpl extends BaseDaoImpl<Volunteer> implements VolunteerDao {

	@Override
	public Long saveAndReturnId(Volunteer model) {
		Serializable volId = this.getHibernateTemplate().save(model);
		return (Long) volId;
	}

}

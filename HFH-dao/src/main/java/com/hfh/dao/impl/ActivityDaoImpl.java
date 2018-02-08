package com.hfh.dao.impl;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hfh.dao.ActivityDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.Activity;
import com.hfh.domain.ActivityVolunteer;
import com.hfh.domain.Volunteer;
import com.hfh.utils.PageBean;

@Repository
public class ActivityDaoImpl extends BaseDaoImpl<Activity> implements ActivityDao {

	@Override
	public List<ActivityVolunteer> listVolunteer(Long act_id) {
		String hql = "FROM ActivityVolunteer WHERE act_id = ?";
		List<ActivityVolunteer> list = (List<ActivityVolunteer>) this.getHibernateTemplate().find(hql, act_id);
		return list;
	}
	
	
}
